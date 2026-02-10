class DbTables {
  static const String products = 'products';
  static const String sessions = 'sessions';
  static const String invoices = 'invoices';
  static const String rooms = 'rooms';
  static const String tables = 'tables';
  static const String orders = 'orders';
  static const String orderItems = 'order_items';
  static const String sessionOrders = 'session_orders';
  static const String profiles = 'profiles';
}

class SessionConstants {
  static const String open = 'open';
  static const String fixed = 'fixed';
  static const String active = 'active';
  static const String paused = 'paused';
  static const String completed = 'completed';
}

class RoomConstants {
  static const String occupied = 'occupied';
  static const String available = 'available';
}

class TableConstants {
  static const String occupied = 'occupied';
  static const String available = 'available';
  static const String maintenance = 'maintenance';
}
