drop extension if exists "pg_net";

drop trigger if exists "tr_update_stock" on "public"."session_orders";

drop trigger if exists "on_session_change" on "public"."sessions";

drop trigger if exists "trigger_update_table_status" on "public"."sessions";

drop policy "Admins can manage cashiers" on "public"."cashiers";

drop policy "Allow admin to delete tables" on "public"."tables";

drop policy "Allow admin to insert tables" on "public"."tables";

drop policy "Allow admin to update tables" on "public"."tables";

alter table "public"."bookings" drop constraint "bookings_room_id_fkey";

alter table "public"."bookings" drop constraint "bookings_user_id_fkey";

alter table "public"."invoices" drop constraint "invoices_customer_id_fkey";

alter table "public"."invoices" drop constraint "invoices_session_id_fkey";

alter table "public"."invoices" drop constraint "invoices_shift_id_fkey";

alter table "public"."session_orders" drop constraint "session_orders_product_id_fkey";

alter table "public"."session_orders" drop constraint "session_orders_session_id_fkey";

alter table "public"."sessions" drop constraint "sessions_booking_id_fkey";

alter table "public"."sessions" drop constraint "sessions_room_id_fkey";

alter table "public"."sessions" drop constraint "sessions_table_id_fkey";

alter table "public"."shifts" drop constraint "shifts_cashier_id_fkey";

drop view if exists "public"."booking_details";

drop view if exists "public"."session_details";

drop view if exists "public"."view_session_details";

drop index if exists "public"."unique_open_shift";

alter table "public"."bookings" alter column "payment_method" set default 'instapay'::public.payment_method;

alter table "public"."bookings" alter column "payment_method" set data type public.payment_method using "payment_method"::text::public.payment_method;

alter table "public"."bookings" alter column "status" set default 'pending_payment'::public.booking_status;

alter table "public"."bookings" alter column "status" set data type public.booking_status using "status"::text::public.booking_status;

alter table "public"."invoices" add column "source_name" text;

alter table "public"."rooms" alter column "current_status" set default 'available'::public.room_status;

alter table "public"."rooms" alter column "current_status" set data type public.room_status using "current_status"::text::public.room_status;

alter table "public"."sessions" alter column "session_type" set default 'open'::public.session_type;

alter table "public"."sessions" alter column "session_type" set data type public.session_type using "session_type"::text::public.session_type;

alter table "public"."sessions" alter column "source" set default 'walk_in'::public.booking_source;

alter table "public"."sessions" alter column "source" set data type public.booking_source using "source"::text::public.booking_source;

alter table "public"."shifts" add column if not exists "cashier_name" text;

alter table "public"."shifts" alter column "status" set default 'open'::public.shift_status;

alter table "public"."shifts" alter column "status" set data type public.shift_status using "status"::text::public.shift_status;

alter table "public"."tables" alter column "id" set default nextval('public.tables_id_seq'::regclass);

CREATE UNIQUE INDEX unique_open_shift ON public.shifts USING btree (status) WHERE (status = 'open'::public.shift_status);

alter table "public"."bookings" add constraint "bookings_room_id_fkey" FOREIGN KEY (room_id) REFERENCES public.rooms(id) not valid;

alter table "public"."bookings" validate constraint "bookings_room_id_fkey";

alter table "public"."bookings" add constraint "bookings_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.app_users(id) not valid;

alter table "public"."bookings" validate constraint "bookings_user_id_fkey";

alter table "public"."invoices" add constraint "invoices_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES public.customers(id) not valid;

alter table "public"."invoices" validate constraint "invoices_customer_id_fkey";

alter table "public"."invoices" add constraint "invoices_session_id_fkey" FOREIGN KEY (session_id) REFERENCES public.sessions(id) not valid;

alter table "public"."invoices" validate constraint "invoices_session_id_fkey";

alter table "public"."invoices" add constraint "invoices_shift_id_fkey" FOREIGN KEY (shift_id) REFERENCES public.shifts(id) not valid;

alter table "public"."invoices" validate constraint "invoices_shift_id_fkey";

alter table "public"."session_orders" add constraint "session_orders_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public.products(id) not valid;

alter table "public"."session_orders" validate constraint "session_orders_product_id_fkey";

alter table "public"."session_orders" add constraint "session_orders_session_id_fkey" FOREIGN KEY (session_id) REFERENCES public.sessions(id) ON DELETE CASCADE not valid;

alter table "public"."session_orders" validate constraint "session_orders_session_id_fkey";

alter table "public"."sessions" add constraint "sessions_booking_id_fkey" FOREIGN KEY (booking_id) REFERENCES public.bookings(id) not valid;

alter table "public"."sessions" validate constraint "sessions_booking_id_fkey";

alter table "public"."sessions" add constraint "sessions_room_id_fkey" FOREIGN KEY (room_id) REFERENCES public.rooms(id) not valid;

alter table "public"."sessions" validate constraint "sessions_room_id_fkey";

alter table "public"."sessions" add constraint "sessions_table_id_fkey" FOREIGN KEY (table_id) REFERENCES public.tables(id) ON DELETE SET NULL not valid;

alter table "public"."sessions" validate constraint "sessions_table_id_fkey";

alter table "public"."shifts" add constraint "shifts_cashier_id_fkey" FOREIGN KEY (cashier_id) REFERENCES public.cashiers(id) not valid;

alter table "public"."shifts" validate constraint "shifts_cashier_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.checkout_session(p_session_id bigint, p_customer_id bigint, p_customer_name text, p_discount_percentage double precision, p_discount_amount double precision, p_total_amount double precision, p_payment_method text, p_shop_name text, p_shift_id bigint)
 RETURNS bigint
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
    status,
    shift_id -- 2. NEW: Targets the new column
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
    'paid',
    p_shift_id -- 3. NEW: Saves the value to the database
  )
  returning id into v_invoice_id;
  
  return v_invoice_id;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.checkout_session(p_session_id bigint, p_customer_id bigint, p_customer_name text, p_discount_percentage double precision, p_discount_amount double precision, p_total_amount double precision, p_payment_method text, p_shop_name text, p_shift_id bigint, p_source_name text)
 RETURNS bigint
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
declare
  v_invoice_id bigint;
  v_invoice_number text;
  v_today_count int;
  v_date_part text;
begin
  -- Generate Invoice Number
  v_date_part := to_char(now() at time zone 'utc', 'YYYYMMDD');
  
  select count(*) into v_today_count from invoices
  where to_char(issued_at at time zone 'utc', 'YYYYMMDD') = v_date_part;
  
  v_invoice_number := 'INV-' || v_date_part || '-' || lpad((v_today_count + 1)::text, 3, '0');
  
  -- Update Session
  update sessions set end_time = now(), status = 'completed' where id = p_session_id;
  
  -- Insert Invoice
  insert into invoices (
    session_id, invoice_number, customer_id, customer_name,
    discount_percentage, discount_amount, total_amount,
    payment_method, shop_name, issued_at, status, shift_id,
    source_name -- ⬅️ NEW: Targets the new column
  ) values (
    p_session_id, v_invoice_number, p_customer_id, p_customer_name,
    p_discount_percentage, p_discount_amount, p_total_amount,
    p_payment_method, p_shop_name, now(), 'paid', p_shift_id,
    p_source_name -- ⬅️ NEW: Saves the value
  )
  returning id into v_invoice_id;
  
  return v_invoice_id;
end;
$function$
;

create or replace view "public"."shift_reports_summary" as  SELECT s.id AS shift_id,
    s.status,
    s.opened_at,
    s.closed_at,
    c.name AS cashier_name,
    s.starting_cash,
    s.cash_revenue,
    s.digital_revenue,
    (COALESCE(s.cash_revenue, (0)::numeric) + COALESCE(s.digital_revenue, (0)::numeric)) AS total_revenue,
    (COALESCE(s.starting_cash, (0)::numeric) + COALESCE(s.cash_revenue, (0)::numeric)) AS expected_ending_cash,
    s.actual_ending_cash,
    s.cash_dropped,
    s.cash_left_in_drawer,
    (COALESCE(s.actual_ending_cash, (0)::numeric) - (COALESCE(s.starting_cash, (0)::numeric) + COALESCE(s.cash_revenue, (0)::numeric))) AS variance,
    s.notes
   FROM (public.shifts s
     JOIN public.cashiers c ON ((s.cashier_id = c.id)));


CREATE OR REPLACE FUNCTION public.update_shift_revenue()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  -- If the invoice is paid in cash, add it to cash_revenue
  IF NEW.payment_method = 'cash' THEN
    UPDATE public.shifts
    SET 
      cash_revenue = COALESCE(cash_revenue, 0) + NEW.total_amount,
      -- Automatically update the expected ending cash too
      expected_ending_cash = COALESCE(starting_cash, 0) + COALESCE(cash_revenue, 0) + NEW.total_amount
    WHERE id = NEW.shift_id;
    
  -- If it is card, instapay, or anything else, add it to digital_revenue
  ELSE
    UPDATE public.shifts
    SET 
      digital_revenue = COALESCE(digital_revenue, 0) + NEW.total_amount
    WHERE id = NEW.shift_id;
  END IF;

  RETURN NEW;
END;
$function$
;

create or replace view "public"."booking_details" as  SELECT id,
    user_id,
    room_id,
    booking_time,
    deposit_amount,
    payment_method,
    transaction_ref,
    proof_image_url,
    status,
    created_at,
    (booking_time + '00:15:00'::interval) AS expires_at
   FROM public.bookings;


create or replace view "public"."session_details" as  SELECT id,
    room_id,
    booking_id,
    start_time,
    end_time,
    source,
    applied_hourly_rate,
    total_product_cost,
    total_time_cost,
    deposit_deducted,
    final_total_bill,
    status,
    created_at,
        CASE
            WHEN (end_time IS NOT NULL) THEN (EXTRACT(epoch FROM (end_time - start_time)) / (60)::numeric)
            ELSE NULL::numeric
        END AS duration_minutes
   FROM public.sessions;


CREATE OR REPLACE FUNCTION public.start_table_session(p_table_id bigint)
 RETURNS public.sessions
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
$function$
;

create or replace view "public"."view_daily_revenue" as  SELECT date(issued_at) AS report_date,
    count(*) AS total_invoices,
    sum(total_amount) AS net_revenue,
    sum(discount_amount) AS total_discount,
    sum((total_amount + discount_amount)) AS gross_revenue,
    sum(
        CASE
            WHEN (payment_method = 'Cash'::text) THEN total_amount
            ELSE (0)::numeric
        END) AS cash_revenue,
    sum(
        CASE
            WHEN (payment_method = 'Card'::text) THEN total_amount
            ELSE (0)::numeric
        END) AS card_revenue
   FROM public.invoices
  WHERE (status <> 'cancelled'::text)
  GROUP BY (date(issued_at))
  ORDER BY (date(issued_at)) DESC;


create or replace view "public"."view_session_details" as  SELECT s.id,
    s.created_at,
    s.total_product_cost,
        CASE
            WHEN (s.room_id IS NULL) THEN 'Waiting Area'::text
            ELSE 'Room'::text
        END AS location_type,
    r.name AS room_name
   FROM (public.sessions s
     LEFT JOIN public.rooms r ON ((s.room_id = r.id)));



  create policy "Admins can manage cashiers"
  on "public"."cashiers"
  as permissive
  for all
  to public
using ((EXISTS ( SELECT 1
   FROM public.app_users
  WHERE ((app_users.id = auth.uid()) AND (app_users.role = 'admin'::text)))))
with check ((EXISTS ( SELECT 1
   FROM public.app_users
  WHERE ((app_users.id = auth.uid()) AND (app_users.role = 'admin'::text)))));



  create policy "Allow admin to delete tables"
  on "public"."tables"
  as permissive
  for delete
  to authenticated
using ((EXISTS ( SELECT 1
   FROM public.app_users
  WHERE ((app_users.id = auth.uid()) AND (app_users.role = 'admin'::text)))));



  create policy "Allow admin to insert tables"
  on "public"."tables"
  as permissive
  for insert
  to authenticated
with check ((EXISTS ( SELECT 1
   FROM public.app_users
  WHERE ((app_users.id = auth.uid()) AND (app_users.role = 'admin'::text)))));



  create policy "Allow admin to update tables"
  on "public"."tables"
  as permissive
  for update
  to authenticated
using ((EXISTS ( SELECT 1
   FROM public.app_users
  WHERE ((app_users.id = auth.uid()) AND (app_users.role = 'admin'::text)))))
with check ((EXISTS ( SELECT 1
   FROM public.app_users
  WHERE ((app_users.id = auth.uid()) AND (app_users.role = 'admin'::text)))));


CREATE TRIGGER on_invoice_created AFTER INSERT ON public.invoices FOR EACH ROW WHEN (((new.shift_id IS NOT NULL) AND (new.status = 'paid'::text))) EXECUTE FUNCTION public.update_shift_revenue();

CREATE TRIGGER tr_update_stock AFTER INSERT OR DELETE OR UPDATE ON public.session_orders FOR EACH ROW EXECUTE FUNCTION public.update_stock_on_order();

CREATE TRIGGER on_session_change AFTER INSERT OR UPDATE ON public.sessions FOR EACH ROW EXECUTE FUNCTION public.sync_room_status();

CREATE TRIGGER trigger_update_table_status AFTER INSERT OR UPDATE OF status ON public.sessions FOR EACH ROW WHEN ((new.table_id IS NOT NULL)) EXECUTE FUNCTION public.update_table_status();


