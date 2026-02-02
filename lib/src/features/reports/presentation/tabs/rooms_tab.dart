import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../reports_providers.dart';

class RoomsTab extends ConsumerWidget {
  const RoomsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomsAsync = ref.watch(roomUsageProvider);

    return roomsAsync.when(
      data: (data) {
        if (data.isEmpty) {
          return const Center(child: Text('No room usage data available.'));
        }

        final double totalHours = data.fold(
          0,
          (sum, item) => sum + item.totalHours,
        );

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
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
                          title: '${percentage.toStringAsFixed(1)}%',
                          radius: 100,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
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
                          Text(
                            '${item.roomName}: ${item.totalHours.toStringAsFixed(1)} hrs',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
