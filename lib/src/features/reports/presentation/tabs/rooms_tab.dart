import 'package:arcade_cashier/src/common_widgets/error_state_widget.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/error_messages.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../reports_providers.dart';

class RoomsTab extends ConsumerWidget {
  const RoomsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final roomsAsync = ref.watch(roomUsageProvider);

    return roomsAsync.when(
      data: (data) {
        if (data.isEmpty) {
          return Center(child: Text(loc.noRoomUsageData));
        }

        final double totalHours = data.fold(
          0,
          (sum, item) => sum + item.totalHours,
        );

        return LayoutBuilder(
          builder: (context, constraints) {
            // Use vertical layout on mobile, horizontal on larger screens
            final isMobile = constraints.maxWidth < 600;

            final pieChart = AspectRatio(
              aspectRatio: isMobile ? 1.2 : 1,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: data.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final color =
                        Colors.primaries[index % Colors.primaries.length];
                    final percentage = totalHours > 0
                        ? (item.totalHours / totalHours) * 100
                        : 0;

                    return PieChartSectionData(
                      color: color,
                      value: item.totalHours,
                      title:
                          '${percentage.toStringAsFixed(1)}${loc.percentSymbol}',
                      radius: isMobile ? 80 : 100,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
            );

            final legend = Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final color =
                    Colors.primaries[index % Colors.primaries.length];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${item.roomName}: ${item.totalHours.toStringAsFixed(1)} ${loc.hoursAbbr}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );

            if (isMobile) {
              // Mobile: Vertical layout
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    pieChart,
                    const SizedBox(height: 24),
                    legend,
                  ],
                ),
              );
            } else {
              // Desktop/Tablet: Horizontal layout
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(child: pieChart),
                    const SizedBox(width: 32),
                    Expanded(child: legend),
                  ],
                ),
              );
            }
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => ErrorStateWidget(
        message: getUserFriendlyErrorMessage(err, context),
        onRetry: () => ref.invalidate(roomUsageProvider),
      ),
    );
  }
}
