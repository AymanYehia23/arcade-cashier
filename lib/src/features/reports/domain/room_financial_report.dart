class RoomFinancialReport {
  final String sourceName;
  final int totalSessions;
  final double totalHours;
  final double totalRevenue;
  final double avgTicket;

  RoomFinancialReport({
    required this.sourceName,
    required this.totalSessions,
    required this.totalHours,
    required this.totalRevenue,
    required this.avgTicket,
  });

  factory RoomFinancialReport.fromJson(Map<String, dynamic> json) {
    return RoomFinancialReport(
      sourceName: json['source_name'] as String? ?? 'Unknown',
      totalSessions: json['total_sessions'] as int? ?? 0,
      totalHours: (json['total_hours'] as num?)?.toDouble() ?? 0.0,
      totalRevenue: (json['total_revenue'] as num?)?.toDouble() ?? 0.0,
      avgTicket: (json['avg_ticket'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
