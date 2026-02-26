


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."booking_source" AS ENUM (
    'walk_in',
    'mobile_app'
);


ALTER TYPE "public"."booking_source" OWNER TO "postgres";


CREATE TYPE "public"."booking_status" AS ENUM (
    'pending_payment',
    'confirmed',
    'checked_in',
    'expired',
    'cancelled_penalty'
);


ALTER TYPE "public"."booking_status" OWNER TO "postgres";


CREATE TYPE "public"."payment_method" AS ENUM (
    'instapay',
    'vodafone_cash',
    'orange_cash',
    'etisalat_cash',
    'cash'
);


ALTER TYPE "public"."payment_method" OWNER TO "postgres";


CREATE TYPE "public"."room_status" AS ENUM (
    'available',
    'occupied',
    'maintenance',
    'held'
);


ALTER TYPE "public"."room_status" OWNER TO "postgres";


CREATE TYPE "public"."session_type" AS ENUM (
    'open',
    'fixed',
    'other'
);


ALTER TYPE "public"."session_type" OWNER TO "postgres";


CREATE TYPE "public"."shift_status" AS ENUM (
    'open',
    'closed'
);


ALTER TYPE "public"."shift_status" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."add_order_item"("p_session_id" bigint, "p_product_id" bigint, "p_price" numeric, "p_quantity" integer) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- We use 'unit_price' here because that matches your table
  INSERT INTO session_orders (session_id, product_id, unit_price, quantity)
  VALUES (p_session_id, p_product_id, p_price, p_quantity)
  ON CONFLICT (session_id, product_id)
  DO UPDATE SET 
    quantity = session_orders.quantity + EXCLUDED.quantity,
    unit_price = EXCLUDED.unit_price; -- Update price to latest if changed
END;
$$;


ALTER FUNCTION "public"."add_order_item"("p_session_id" bigint, "p_product_id" bigint, "p_price" numeric, "p_quantity" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."checkout_session"("p_session_id" bigint, "p_customer_id" bigint, "p_customer_name" "text", "p_discount_percentage" double precision, "p_discount_amount" double precision, "p_total_amount" double precision, "p_payment_method" "text", "p_shop_name" "text") RETURNS bigint
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
declare
  v_invoice_id bigint;
  v_invoice_number text;
  v_today_count int;
  v_date_part text;
begin
  -- 1. Generate Invoice Number
  -- Get date part as YYYYMMDD based on Server Time (UTC recommended)
  v_date_part := to_char(now() at time zone 'utc', 'YYYYMMDD');
  
  -- Count invoices for today (simple count, adequate for low concurrency)
  -- Uses issued_at to match the date pattern
  select count(*)
  into v_today_count
  from invoices
  where to_char(issued_at at time zone 'utc', 'YYYYMMDD') = v_date_part;
  
  -- Format: INV-YYYYMMDD-XXX
  v_invoice_number := 'INV-' || v_date_part || '-' || lpad((v_today_count + 1)::text, 3, '0');
  -- 2. Update Session
  -- Mark session as completed and set end_time
  update sessions
  set 
    end_time = now(),
    status = 'completed'
  where id = p_session_id;
  -- 3. Insert Invoice
  insert into invoices (
    session_id,
    invoice_number,
    customer_id,
    customer_name,
    discount_percentage,
    discount_amount,
    total_amount,
    payment_method,
    shop_name,
    issued_at,
    status
  ) values (
    p_session_id,
    v_invoice_number,
    p_customer_id,
    p_customer_name,
    p_discount_percentage,
    p_discount_amount,
    p_total_amount,
    p_payment_method,
    p_shop_name,
    now(),
    'paid'
  )
  returning id into v_invoice_id;
  return v_invoice_id;
end;
$$;


ALTER FUNCTION "public"."checkout_session"("p_session_id" bigint, "p_customer_id" bigint, "p_customer_name" "text", "p_discount_percentage" double precision, "p_discount_amount" double precision, "p_total_amount" double precision, "p_payment_method" "text", "p_shop_name" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_product_performance"("start_date" timestamp with time zone, "end_date" timestamp with time zone) RETURNS TABLE("product_name" "text", "category" "text", "total_sold" bigint, "total_revenue" numeric)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY
  SELECT 
    p.name as product_name,
    p.category,
    SUM(so.quantity)::BIGINT as total_sold,
    SUM(so.quantity * so.unit_price) as total_revenue
  FROM session_orders so
  JOIN products p ON so.product_id = p.id
  WHERE so.created_at >= start_date 
    AND so.created_at <= end_date
  GROUP BY p.id, p.name, p.category
  ORDER BY total_sold DESC
  LIMIT 10;
END;
$$;


ALTER FUNCTION "public"."get_product_performance"("start_date" timestamp with time zone, "end_date" timestamp with time zone) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_room_financials"("start_date" timestamp with time zone, "end_date" timestamp with time zone) RETURNS TABLE("source_name" "text", "total_sessions" bigint, "total_hours" numeric, "total_revenue" numeric, "avg_ticket" numeric)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY
  SELECT 
    COALESCE(r.name, 'Quick Orders (Walk-in)') as source_name,
    COUNT(s.id)::BIGINT as total_sessions,
    
    -- Calculate Hours (0 for Quick Orders)
    SUM(
      CASE WHEN s.room_id IS NULL THEN 0 
      ELSE EXTRACT(EPOCH FROM (s.end_time - s.start_time))/3600 
      END
    )::NUMERIC(10,1) as total_hours,

    -- Sum the FINAL invoice amount (Net Revenue)
    SUM(i.total_amount) as total_revenue,

    -- Calculate Average Ticket (Revenue / Count)
    ROUND(SUM(i.total_amount) / COUNT(s.id), 2) as avg_ticket

  FROM sessions s
  JOIN invoices i ON i.session_id = s.id -- Only count paid sessions
  LEFT JOIN rooms r ON s.room_id = r.id
  WHERE i.issued_at >= start_date 
    AND i.issued_at <= end_date
    AND i.status != 'cancelled'
  GROUP BY r.name, s.room_id
  ORDER BY total_revenue DESC; -- Show highest earners first
END;
$$;


ALTER FUNCTION "public"."get_room_financials"("start_date" timestamp with time zone, "end_date" timestamp with time zone) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_room_usage"("start_date" timestamp with time zone, "end_date" timestamp with time zone) RETURNS TABLE("room_name" "text", "total_sessions" bigint, "total_hours" numeric)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY
  SELECT 
    COALESCE(r.name, 'Waiting Area') as room_name,
    COUNT(s.id)::BIGINT as total_sessions,
    SUM(EXTRACT(EPOCH FROM (s.end_time - s.start_time))/3600)::NUMERIC(10,1) as total_hours
  FROM sessions s
  LEFT JOIN rooms r ON s.room_id = r.id
  WHERE s.end_time IS NOT NULL
    AND s.end_time >= start_date 
    AND s.end_time <= end_date
  GROUP BY r.name
  ORDER BY total_hours DESC;
END;
$$;


ALTER FUNCTION "public"."get_room_usage"("start_date" timestamp with time zone, "end_date" timestamp with time zone) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_shift_report"("target_date" timestamp with time zone) RETURNS TABLE("total_cash" numeric, "total_card" numeric, "total_revenue" numeric, "total_discount" numeric, "transactions_count" bigint)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY
  SELECT 
    -- 1. Fix: Use ILIKE (Case Insensitive) and TRIM (Remove spaces)
    COALESCE(SUM(CASE WHEN TRIM(payment_method) ILIKE 'Cash' THEN total_amount ELSE 0 END), 0) as total_cash,
    
    COALESCE(SUM(CASE WHEN TRIM(payment_method) ILIKE 'Card' THEN total_amount ELSE 0 END), 0) as total_card,
    
    COALESCE(SUM(total_amount), 0) as total_revenue,
    COALESCE(SUM(discount_amount), 0) as total_discount,
    COUNT(id)::BIGINT as transactions_count
  FROM invoices
  WHERE 
    status != 'cancelled' AND
    DATE(issued_at) = DATE(target_date);
END;
$$;


ALTER FUNCTION "public"."get_shift_report"("target_date" timestamp with time zone) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  INSERT INTO public.app_users (id, email, role)
  VALUES (new.id, new.email, 'customer'); -- Default to customer
  RETURN new;
END;
$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."sessions" (
    "id" bigint NOT NULL,
    "room_id" bigint,
    "booking_id" bigint,
    "start_time" timestamp with time zone DEFAULT "now"(),
    "end_time" timestamp with time zone,
    "source" "public"."booking_source" DEFAULT 'walk_in'::"public"."booking_source",
    "applied_hourly_rate" numeric(10,2) NOT NULL,
    "total_product_cost" numeric(10,2) DEFAULT 0.00,
    "total_time_cost" numeric(10,2) DEFAULT 0.00,
    "deposit_deducted" numeric(10,2) DEFAULT 0.00,
    "final_total_bill" numeric(10,2) DEFAULT 0.00,
    "status" "text" DEFAULT 'active'::"text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "is_multi_match" boolean DEFAULT false,
    "session_type" "public"."session_type" DEFAULT 'open'::"public"."session_type",
    "planned_duration_minutes" integer,
    "extension_minutes" integer DEFAULT 0,
    "paused_at" timestamp with time zone,
    "total_paused_duration_seconds" integer DEFAULT 0 NOT NULL,
    "match_type" "text" DEFAULT 'single'::"text" NOT NULL,
    "table_id" bigint,
    CONSTRAINT "chk_session_seating" CHECK (((("room_id" IS NOT NULL) AND ("table_id" IS NULL)) OR (("room_id" IS NULL) AND ("table_id" IS NOT NULL)) OR (("room_id" IS NULL) AND ("table_id" IS NULL))))
);


ALTER TABLE "public"."sessions" OWNER TO "postgres";


COMMENT ON COLUMN "public"."sessions"."table_id" IS 'Foreign key to tables - null for room sessions and quick orders';



CREATE OR REPLACE FUNCTION "public"."start_table_session"("p_table_id" bigint) RETURNS "public"."sessions"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  v_session sessions;
  v_table_status TEXT;
BEGIN
  -- Check if table exists and get its status
  SELECT current_status INTO v_table_status
  FROM tables
  WHERE id = p_table_id;

  -- If table doesn't exist
  IF v_table_status IS NULL THEN
    RAISE EXCEPTION 'Table with ID % does not exist', p_table_id;
  END IF;

  -- If table is not available
  IF v_table_status != 'available' THEN
    RAISE EXCEPTION 'Table is not available (current status: %)', v_table_status;
  END IF;

  -- Check if there's already an active session for this table
  IF EXISTS (
    SELECT 1 FROM sessions
    WHERE table_id = p_table_id
      AND status = 'active'
  ) THEN
    RAISE EXCEPTION 'Table already has an active session';
  END IF;

  -- Create session for table
  INSERT INTO sessions (
    table_id,
    start_time,
    applied_hourly_rate,
    match_type,
    session_type,
    source,
    status
  ) VALUES (
    p_table_id,
    now(),
    0.0,           -- No hourly rate for tables
    'other',       -- Default match type
    'open',        -- Always open-ended for tables
    'walk_in',
    'active'
  )
  RETURNING * INTO v_session;

  RETURN v_session;
END;
$$;


ALTER FUNCTION "public"."start_table_session"("p_table_id" bigint) OWNER TO "postgres";


COMMENT ON FUNCTION "public"."start_table_session"("p_table_id" bigint) IS 'Starts a new session for a cafe table with 0 hourly rate';



CREATE OR REPLACE FUNCTION "public"."sync_room_status"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  -- SCENARIO A: New Session Starts -> Always Occupy
  IF (TG_OP = 'INSERT') THEN
    UPDATE public.rooms
    SET current_status = 'occupied'
    WHERE id = NEW.room_id;
  
  -- SCENARIO B: Session Ends -> Check before freeing!
  ELSIF (TG_OP = 'UPDATE') THEN
    IF (NEW.end_time IS NOT NULL OR NEW.status IN ('completed', 'cancelled')) THEN
      
      -- 🛑 GUARD CLAUSE: Are there any OTHER active sessions for this room?
      IF NOT EXISTS (
        SELECT 1 FROM sessions 
        WHERE room_id = NEW.room_id 
        AND status = 'active' 
        AND id != NEW.id -- Don't count the one we just finished
      ) THEN
        -- Only THEN make it available
        UPDATE public.rooms
        SET current_status = 'available'
        WHERE id = NEW.room_id;
      END IF;
      
    END IF;
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."sync_room_status"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_stock_on_order"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  v_diff INTEGER;
BEGIN
  -- Handle ADDING a new row
  IF (TG_OP = 'INSERT') THEN
    IF (SELECT stock_quantity FROM products WHERE id = NEW.product_id) < NEW.quantity THEN
       RAISE EXCEPTION 'Insufficient stock';
    END IF;
    UPDATE products SET stock_quantity = stock_quantity - NEW.quantity WHERE id = NEW.product_id;
    RETURN NEW;
  
  -- Handle REMOVING a row
  ELSIF (TG_OP = 'DELETE') THEN
    UPDATE products SET stock_quantity = stock_quantity + OLD.quantity WHERE id = OLD.product_id;
    RETURN OLD;

  -- Handle UPDATING quantity (e.g. 1 -> 2)
  ELSIF (TG_OP = 'UPDATE') THEN
    v_diff := NEW.quantity - OLD.quantity; -- If 1 -> 2, diff is 1. If 2 -> 1, diff is -1.
    
    IF v_diff > 0 THEN
       IF (SELECT stock_quantity FROM products WHERE id = NEW.product_id) < v_diff THEN
          RAISE EXCEPTION 'Insufficient stock for increase';
       END IF;
    END IF;

    UPDATE products SET stock_quantity = stock_quantity - v_diff WHERE id = NEW.product_id;
    RETURN NEW;
  END IF;
  
  RETURN NULL;
END;
$$;


ALTER FUNCTION "public"."update_stock_on_order"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_table_status"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  -- 1. Start: Always Occupy
  IF (TG_OP = 'INSERT' AND NEW.table_id IS NOT NULL AND NEW.status = 'active') THEN
    UPDATE tables SET current_status = 'occupied' WHERE id = NEW.table_id;
  END IF;

  -- 2. End: Check 'Completed' OR 'Cancelled'
  IF (TG_OP = 'UPDATE' AND NEW.table_id IS NOT NULL) THEN
    
    -- Check if the session is finishing NOW
    IF (NEW.status IN ('completed', 'cancelled') AND OLD.status = 'active') THEN
      
      -- GUARD: Are there other active sessions for this table?
      IF NOT EXISTS (
        SELECT 1 FROM sessions 
        WHERE table_id = NEW.table_id 
        AND status = 'active' 
        AND id != NEW.id
      ) THEN
        UPDATE tables SET current_status = 'available' WHERE id = NEW.table_id;
      END IF;
      
    END IF;
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_table_status"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."update_table_status"() IS 'Automatically updates table status when sessions start/end';



CREATE TABLE IF NOT EXISTS "public"."app_users" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "phone_number" "text" NOT NULL,
    "full_name" "text",
    "loyalty_points" integer DEFAULT 0,
    "is_banned" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "role" "text" DEFAULT 'customer'::"text" NOT NULL,
    "email" "text",
    CONSTRAINT "check_user_role" CHECK (("role" = ANY (ARRAY['admin'::"text", 'cashier'::"text", 'customer'::"text"])))
);


ALTER TABLE "public"."app_users" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."bookings" (
    "id" bigint NOT NULL,
    "user_id" "uuid",
    "room_id" bigint,
    "booking_time" timestamp with time zone DEFAULT "now"(),
    "deposit_amount" numeric(10,2) DEFAULT 20.00,
    "payment_method" "public"."payment_method" DEFAULT 'instapay'::"public"."payment_method",
    "transaction_ref" "text",
    "proof_image_url" "text",
    "status" "public"."booking_status" DEFAULT 'pending_payment'::"public"."booking_status",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."bookings" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."booking_details" WITH ("security_invoker"='on') AS
 SELECT "id",
    "user_id",
    "room_id",
    "booking_time",
    "deposit_amount",
    "payment_method",
    "transaction_ref",
    "proof_image_url",
    "status",
    "created_at",
    ("booking_time" + '00:15:00'::interval) AS "expires_at"
   FROM "public"."bookings";


ALTER VIEW "public"."booking_details" OWNER TO "postgres";


ALTER TABLE "public"."bookings" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."bookings_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."cashiers" (
    "id" bigint NOT NULL,
    "name" "text" NOT NULL,
    "pin_code" "text" NOT NULL,
    "is_active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."cashiers" OWNER TO "postgres";


ALTER TABLE "public"."cashiers" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."cashiers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."customers" (
    "id" bigint NOT NULL,
    "name" "text" NOT NULL,
    "phone" "text" NOT NULL,
    "loyalty_points" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."customers" OWNER TO "postgres";


ALTER TABLE "public"."customers" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."customers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."invoices" (
    "id" bigint NOT NULL,
    "session_id" bigint NOT NULL,
    "invoice_number" "text" NOT NULL,
    "shop_name" "text" DEFAULT 'Arcade Station'::"text" NOT NULL,
    "total_amount" numeric(10,2) NOT NULL,
    "payment_method" "text" DEFAULT 'Cash'::"text",
    "issued_at" timestamp with time zone DEFAULT "now"(),
    "pdf_url" "text",
    "status" "text" DEFAULT 'paid'::"text" NOT NULL,
    "cancelled_at" timestamp with time zone,
    "discount_amount" numeric(10,2) DEFAULT 0.0 NOT NULL,
    "discount_percentage" numeric(5,2) DEFAULT 0.0 NOT NULL,
    "customer_id" bigint,
    "customer_name" "text",
    "shift_id" bigint
);


ALTER TABLE "public"."invoices" OWNER TO "postgres";


ALTER TABLE "public"."invoices" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."invoices_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."products" (
    "id" bigint NOT NULL,
    "name" "text" NOT NULL,
    "category" "text",
    "purchase_price" numeric(10,2) DEFAULT 0,
    "selling_price" numeric(10,2) NOT NULL,
    "stock_quantity" integer DEFAULT 0,
    "is_active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "name_ar" "text",
    "category_ar" "text"
);


ALTER TABLE "public"."products" OWNER TO "postgres";


ALTER TABLE "public"."products" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."products_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."rooms" (
    "id" bigint NOT NULL,
    "name" "text" NOT NULL,
    "device_type" "text" NOT NULL,
    "hourly_rate" numeric(10,2) NOT NULL,
    "current_status" "public"."room_status" DEFAULT 'available'::"public"."room_status",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "multi_player_hourly_rate" numeric(10,2) DEFAULT 0.00,
    "other_hourly_rate" numeric DEFAULT 0.0
);


ALTER TABLE "public"."rooms" OWNER TO "postgres";


ALTER TABLE "public"."rooms" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."rooms_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE OR REPLACE VIEW "public"."session_details" WITH ("security_invoker"='on') AS
 SELECT "id",
    "room_id",
    "booking_id",
    "start_time",
    "end_time",
    "source",
    "applied_hourly_rate",
    "total_product_cost",
    "total_time_cost",
    "deposit_deducted",
    "final_total_bill",
    "status",
    "created_at",
        CASE
            WHEN ("end_time" IS NOT NULL) THEN (EXTRACT(epoch FROM ("end_time" - "start_time")) / (60)::numeric)
            ELSE NULL::numeric
        END AS "duration_minutes"
   FROM "public"."sessions";


ALTER VIEW "public"."session_details" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."session_orders" (
    "id" bigint NOT NULL,
    "session_id" bigint,
    "product_id" bigint,
    "quantity" integer DEFAULT 1,
    "unit_price" numeric(10,2) NOT NULL,
    "total_price" numeric(10,2) GENERATED ALWAYS AS ((("quantity")::numeric * "unit_price")) STORED,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."session_orders" OWNER TO "postgres";


ALTER TABLE "public"."session_orders" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."session_orders_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



ALTER TABLE "public"."sessions" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."sessions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."shifts" (
    "id" bigint NOT NULL,
    "cashier_id" bigint NOT NULL,
    "status" "public"."shift_status" DEFAULT 'open'::"public"."shift_status",
    "opened_at" timestamp with time zone DEFAULT "now"(),
    "closed_at" timestamp with time zone,
    "starting_cash" numeric DEFAULT 0.00 NOT NULL,
    "cash_revenue" numeric DEFAULT 0.00,
    "digital_revenue" numeric DEFAULT 0.00,
    "expected_ending_cash" numeric,
    "actual_ending_cash" numeric,
    "cash_dropped" numeric,
    "cash_left_in_drawer" numeric,
    "notes" "text",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."shifts" OWNER TO "postgres";


ALTER TABLE "public"."shifts" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."shifts_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."tables" (
    "id" bigint NOT NULL,
    "name" "text" NOT NULL,
    "table_number" integer,
    "current_status" "text" DEFAULT 'available'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "chk_table_status" CHECK (("current_status" = ANY (ARRAY['available'::"text", 'occupied'::"text", 'maintenance'::"text"])))
);


ALTER TABLE "public"."tables" OWNER TO "postgres";


COMMENT ON TABLE "public"."tables" IS 'Cafe tables for customers ordering food/drinks without gaming';



COMMENT ON COLUMN "public"."tables"."name" IS 'Display name of the table (e.g., "Table 1", "Table A")';



COMMENT ON COLUMN "public"."tables"."table_number" IS 'Optional numeric ordering for sorting';



COMMENT ON COLUMN "public"."tables"."current_status" IS 'Current availability status: available, occupied, maintenance';



CREATE SEQUENCE IF NOT EXISTS "public"."tables_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."tables_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."tables_id_seq" OWNED BY "public"."tables"."id";



CREATE OR REPLACE VIEW "public"."view_daily_revenue" WITH ("security_invoker"='on') AS
 SELECT "date"("issued_at") AS "report_date",
    "count"(*) AS "total_invoices",
    "sum"("total_amount") AS "net_revenue",
    "sum"("discount_amount") AS "total_discount",
    "sum"(("total_amount" + "discount_amount")) AS "gross_revenue",
    "sum"(
        CASE
            WHEN ("payment_method" = 'Cash'::"text") THEN "total_amount"
            ELSE (0)::numeric
        END) AS "cash_revenue",
    "sum"(
        CASE
            WHEN ("payment_method" = 'Card'::"text") THEN "total_amount"
            ELSE (0)::numeric
        END) AS "card_revenue"
   FROM "public"."invoices"
  WHERE ("status" <> 'cancelled'::"text")
  GROUP BY ("date"("issued_at"))
  ORDER BY ("date"("issued_at")) DESC;


ALTER VIEW "public"."view_daily_revenue" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_session_details" WITH ("security_invoker"='on') AS
 SELECT "s"."id",
    "s"."created_at",
    "s"."total_product_cost",
        CASE
            WHEN ("s"."room_id" IS NULL) THEN 'Waiting Area'::"text"
            ELSE 'Room'::"text"
        END AS "location_type",
    "r"."name" AS "room_name"
   FROM ("public"."sessions" "s"
     LEFT JOIN "public"."rooms" "r" ON (("s"."room_id" = "r"."id")));


ALTER VIEW "public"."view_session_details" OWNER TO "postgres";


ALTER TABLE ONLY "public"."tables" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."tables_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."app_users"
    ADD CONSTRAINT "app_users_phone_number_key" UNIQUE ("phone_number");



ALTER TABLE ONLY "public"."app_users"
    ADD CONSTRAINT "app_users_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."bookings"
    ADD CONSTRAINT "bookings_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."bookings"
    ADD CONSTRAINT "bookings_transaction_ref_key" UNIQUE ("transaction_ref");



ALTER TABLE ONLY "public"."cashiers"
    ADD CONSTRAINT "cashiers_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."customers"
    ADD CONSTRAINT "customers_phone_key" UNIQUE ("phone");



ALTER TABLE ONLY "public"."customers"
    ADD CONSTRAINT "customers_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."invoices"
    ADD CONSTRAINT "invoices_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."products"
    ADD CONSTRAINT "products_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."rooms"
    ADD CONSTRAINT "rooms_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."session_orders"
    ADD CONSTRAINT "session_orders_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."sessions"
    ADD CONSTRAINT "sessions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."shifts"
    ADD CONSTRAINT "shifts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tables"
    ADD CONSTRAINT "tables_name_key" UNIQUE ("name");



ALTER TABLE ONLY "public"."tables"
    ADD CONSTRAINT "tables_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."session_orders"
    ADD CONSTRAINT "unique_session_product" UNIQUE ("session_id", "product_id");



CREATE INDEX "idx_invoices_issued_at" ON "public"."invoices" USING "btree" ("issued_at" DESC);



CREATE INDEX "idx_invoices_session_id" ON "public"."invoices" USING "btree" ("session_id");



CREATE INDEX "idx_sessions_table_id" ON "public"."sessions" USING "btree" ("table_id");



CREATE INDEX "idx_tables_status" ON "public"."tables" USING "btree" ("current_status");



CREATE UNIQUE INDEX "unique_active_session_per_room" ON "public"."sessions" USING "btree" ("room_id") WHERE ("status" = 'active'::"text");



CREATE UNIQUE INDEX "unique_active_session_per_table" ON "public"."sessions" USING "btree" ("table_id") WHERE ("status" = 'active'::"text");



CREATE UNIQUE INDEX "unique_open_shift" ON "public"."shifts" USING "btree" ("status") WHERE ("status" = 'open'::"public"."shift_status");



CREATE OR REPLACE TRIGGER "on_session_change" AFTER INSERT OR UPDATE ON "public"."sessions" FOR EACH ROW EXECUTE FUNCTION "public"."sync_room_status"();



CREATE OR REPLACE TRIGGER "tr_update_stock" AFTER INSERT OR DELETE OR UPDATE ON "public"."session_orders" FOR EACH ROW EXECUTE FUNCTION "public"."update_stock_on_order"();



CREATE OR REPLACE TRIGGER "trigger_update_table_status" AFTER INSERT OR UPDATE OF "status" ON "public"."sessions" FOR EACH ROW WHEN (("new"."table_id" IS NOT NULL)) EXECUTE FUNCTION "public"."update_table_status"();



ALTER TABLE ONLY "public"."bookings"
    ADD CONSTRAINT "bookings_room_id_fkey" FOREIGN KEY ("room_id") REFERENCES "public"."rooms"("id");



ALTER TABLE ONLY "public"."bookings"
    ADD CONSTRAINT "bookings_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."app_users"("id");



ALTER TABLE ONLY "public"."invoices"
    ADD CONSTRAINT "invoices_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id");



ALTER TABLE ONLY "public"."invoices"
    ADD CONSTRAINT "invoices_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "public"."sessions"("id");



ALTER TABLE ONLY "public"."invoices"
    ADD CONSTRAINT "invoices_shift_id_fkey" FOREIGN KEY ("shift_id") REFERENCES "public"."shifts"("id");



ALTER TABLE ONLY "public"."session_orders"
    ADD CONSTRAINT "session_orders_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."products"("id");



ALTER TABLE ONLY "public"."session_orders"
    ADD CONSTRAINT "session_orders_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "public"."sessions"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."sessions"
    ADD CONSTRAINT "sessions_booking_id_fkey" FOREIGN KEY ("booking_id") REFERENCES "public"."bookings"("id");



ALTER TABLE ONLY "public"."sessions"
    ADD CONSTRAINT "sessions_room_id_fkey" FOREIGN KEY ("room_id") REFERENCES "public"."rooms"("id");



ALTER TABLE ONLY "public"."sessions"
    ADD CONSTRAINT "sessions_table_id_fkey" FOREIGN KEY ("table_id") REFERENCES "public"."tables"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."shifts"
    ADD CONSTRAINT "shifts_cashier_id_fkey" FOREIGN KEY ("cashier_id") REFERENCES "public"."cashiers"("id");



CREATE POLICY "Admins can do everything on bookings" ON "public"."bookings" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Admins can do everything on products" ON "public"."products" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Admins can do everything on rooms" ON "public"."rooms" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Admins can do everything on session_orders" ON "public"."session_orders" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Admins can do everything on sessions" ON "public"."sessions" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Admins can manage cashiers" ON "public"."cashiers" USING ((EXISTS ( SELECT 1
   FROM "public"."app_users"
  WHERE (("app_users"."id" = "auth"."uid"()) AND ("app_users"."role" = 'admin'::"text"))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."app_users"
  WHERE (("app_users"."id" = "auth"."uid"()) AND ("app_users"."role" = 'admin'::"text")))));



CREATE POLICY "Allow admin to delete tables" ON "public"."tables" FOR DELETE TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."app_users"
  WHERE (("app_users"."id" = "auth"."uid"()) AND ("app_users"."role" = 'admin'::"text")))));



CREATE POLICY "Allow admin to insert tables" ON "public"."tables" FOR INSERT TO "authenticated" WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."app_users"
  WHERE (("app_users"."id" = "auth"."uid"()) AND ("app_users"."role" = 'admin'::"text")))));



CREATE POLICY "Allow admin to update tables" ON "public"."tables" FOR UPDATE TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."app_users"
  WHERE (("app_users"."id" = "auth"."uid"()) AND ("app_users"."role" = 'admin'::"text"))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."app_users"
  WHERE (("app_users"."id" = "auth"."uid"()) AND ("app_users"."role" = 'admin'::"text")))));



CREATE POLICY "Allow authenticated to read app_users" ON "public"."app_users" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Allow authenticated to view tables" ON "public"."tables" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Allow authenticated users to insert invoices" ON "public"."invoices" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Allow authenticated users to read invoices" ON "public"."invoices" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Allow authenticated users to update invoices" ON "public"."invoices" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Allow authenticated users to view tables" ON "public"."tables" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Authenticated users can manage shifts" ON "public"."shifts" USING (("auth"."role"() = 'authenticated'::"text")) WITH CHECK (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Authenticated users can view cashiers" ON "public"."cashiers" FOR SELECT USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Enable all access for authenticated users" ON "public"."customers" USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Enable all access for authenticated users" ON "public"."invoices" USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Enable all access for authenticated users" ON "public"."products" USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Enable all access for authenticated users" ON "public"."session_orders" USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Enable all access for authenticated users" ON "public"."sessions" USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Prevent invoice deletion" ON "public"."invoices" FOR DELETE USING (false);



CREATE POLICY "Users can read their own profile" ON "public"."app_users" FOR SELECT USING (("auth"."uid"() = "id"));



ALTER TABLE "public"."app_users" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."bookings" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."cashiers" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."customers" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."invoices" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."products" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."rooms" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."session_orders" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."sessions" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."shifts" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."tables" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."cashiers";



ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."rooms";



ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."sessions";



ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."shifts";



GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

























































































































































GRANT ALL ON FUNCTION "public"."add_order_item"("p_session_id" bigint, "p_product_id" bigint, "p_price" numeric, "p_quantity" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."add_order_item"("p_session_id" bigint, "p_product_id" bigint, "p_price" numeric, "p_quantity" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."add_order_item"("p_session_id" bigint, "p_product_id" bigint, "p_price" numeric, "p_quantity" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."checkout_session"("p_session_id" bigint, "p_customer_id" bigint, "p_customer_name" "text", "p_discount_percentage" double precision, "p_discount_amount" double precision, "p_total_amount" double precision, "p_payment_method" "text", "p_shop_name" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."checkout_session"("p_session_id" bigint, "p_customer_id" bigint, "p_customer_name" "text", "p_discount_percentage" double precision, "p_discount_amount" double precision, "p_total_amount" double precision, "p_payment_method" "text", "p_shop_name" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."checkout_session"("p_session_id" bigint, "p_customer_id" bigint, "p_customer_name" "text", "p_discount_percentage" double precision, "p_discount_amount" double precision, "p_total_amount" double precision, "p_payment_method" "text", "p_shop_name" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_product_performance"("start_date" timestamp with time zone, "end_date" timestamp with time zone) TO "anon";
GRANT ALL ON FUNCTION "public"."get_product_performance"("start_date" timestamp with time zone, "end_date" timestamp with time zone) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_product_performance"("start_date" timestamp with time zone, "end_date" timestamp with time zone) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_room_financials"("start_date" timestamp with time zone, "end_date" timestamp with time zone) TO "anon";
GRANT ALL ON FUNCTION "public"."get_room_financials"("start_date" timestamp with time zone, "end_date" timestamp with time zone) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_room_financials"("start_date" timestamp with time zone, "end_date" timestamp with time zone) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_room_usage"("start_date" timestamp with time zone, "end_date" timestamp with time zone) TO "anon";
GRANT ALL ON FUNCTION "public"."get_room_usage"("start_date" timestamp with time zone, "end_date" timestamp with time zone) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_room_usage"("start_date" timestamp with time zone, "end_date" timestamp with time zone) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_shift_report"("target_date" timestamp with time zone) TO "anon";
GRANT ALL ON FUNCTION "public"."get_shift_report"("target_date" timestamp with time zone) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_shift_report"("target_date" timestamp with time zone) TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



GRANT ALL ON TABLE "public"."sessions" TO "anon";
GRANT ALL ON TABLE "public"."sessions" TO "authenticated";
GRANT ALL ON TABLE "public"."sessions" TO "service_role";



GRANT ALL ON FUNCTION "public"."start_table_session"("p_table_id" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."start_table_session"("p_table_id" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."start_table_session"("p_table_id" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."sync_room_status"() TO "anon";
GRANT ALL ON FUNCTION "public"."sync_room_status"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."sync_room_status"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_stock_on_order"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_stock_on_order"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_stock_on_order"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_table_status"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_table_status"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_table_status"() TO "service_role";


















GRANT ALL ON TABLE "public"."app_users" TO "anon";
GRANT ALL ON TABLE "public"."app_users" TO "authenticated";
GRANT ALL ON TABLE "public"."app_users" TO "service_role";



GRANT ALL ON TABLE "public"."bookings" TO "anon";
GRANT ALL ON TABLE "public"."bookings" TO "authenticated";
GRANT ALL ON TABLE "public"."bookings" TO "service_role";



GRANT ALL ON TABLE "public"."booking_details" TO "anon";
GRANT ALL ON TABLE "public"."booking_details" TO "authenticated";
GRANT ALL ON TABLE "public"."booking_details" TO "service_role";



GRANT ALL ON SEQUENCE "public"."bookings_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."bookings_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."bookings_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."cashiers" TO "anon";
GRANT ALL ON TABLE "public"."cashiers" TO "authenticated";
GRANT ALL ON TABLE "public"."cashiers" TO "service_role";



GRANT ALL ON SEQUENCE "public"."cashiers_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."cashiers_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."cashiers_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."customers" TO "anon";
GRANT ALL ON TABLE "public"."customers" TO "authenticated";
GRANT ALL ON TABLE "public"."customers" TO "service_role";



GRANT ALL ON SEQUENCE "public"."customers_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."customers_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."customers_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."invoices" TO "anon";
GRANT ALL ON TABLE "public"."invoices" TO "authenticated";
GRANT ALL ON TABLE "public"."invoices" TO "service_role";



GRANT ALL ON SEQUENCE "public"."invoices_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."invoices_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."invoices_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."products" TO "anon";
GRANT ALL ON TABLE "public"."products" TO "authenticated";
GRANT ALL ON TABLE "public"."products" TO "service_role";



GRANT ALL ON SEQUENCE "public"."products_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."products_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."products_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."rooms" TO "anon";
GRANT ALL ON TABLE "public"."rooms" TO "authenticated";
GRANT ALL ON TABLE "public"."rooms" TO "service_role";



GRANT ALL ON SEQUENCE "public"."rooms_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."rooms_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."rooms_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."session_details" TO "anon";
GRANT ALL ON TABLE "public"."session_details" TO "authenticated";
GRANT ALL ON TABLE "public"."session_details" TO "service_role";



GRANT ALL ON TABLE "public"."session_orders" TO "anon";
GRANT ALL ON TABLE "public"."session_orders" TO "authenticated";
GRANT ALL ON TABLE "public"."session_orders" TO "service_role";



GRANT ALL ON SEQUENCE "public"."session_orders_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."session_orders_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."session_orders_id_seq" TO "service_role";



GRANT ALL ON SEQUENCE "public"."sessions_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."sessions_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."sessions_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."shifts" TO "anon";
GRANT ALL ON TABLE "public"."shifts" TO "authenticated";
GRANT ALL ON TABLE "public"."shifts" TO "service_role";



GRANT ALL ON SEQUENCE "public"."shifts_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."shifts_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."shifts_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."tables" TO "anon";
GRANT ALL ON TABLE "public"."tables" TO "authenticated";
GRANT ALL ON TABLE "public"."tables" TO "service_role";



GRANT ALL ON SEQUENCE "public"."tables_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."tables_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."tables_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."view_daily_revenue" TO "anon";
GRANT ALL ON TABLE "public"."view_daily_revenue" TO "authenticated";
GRANT ALL ON TABLE "public"."view_daily_revenue" TO "service_role";



GRANT ALL ON TABLE "public"."view_session_details" TO "anon";
GRANT ALL ON TABLE "public"."view_session_details" TO "authenticated";
GRANT ALL ON TABLE "public"."view_session_details" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































