import 'package:crmacsinsights/Core/Constants/Colors.dart';
import 'package:crmacsinsights/Features/Profile/Controller/ProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LeadData {
  final String category;
  final int count;
  final Color color;

  LeadData({required this.category, required this.count, required this.color});
}

class LeadAnalyticsChart extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lead Analytics',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 16),
          Obx(() {
            final data = profileController.pieChartData.value;
            final totalLeads = profileController.totalLeads;

            if (profileController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            // If totalLeads is 0, show a placeholder
            if (totalLeads == 0) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.pie_chart_outline,
                        size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 12),
                    Text(
                      'No lead data available',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              );
            }


            return SfCircularChart(
              margin: EdgeInsets.zero,
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                overflowMode: LegendItemOverflowMode.wrap,
                textStyle: Theme.of(context).textTheme.bodyMedium,
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CircularSeries>[
                DoughnutSeries<LeadData, String>(
                  dataSource: [
                    LeadData(
                        category: 'New Call',
                        count: data?.newCall ?? 0,
                        color: AppColors.newCall),
                    LeadData(
                        category: 'Follow Up',
                        count: data?.followUp ?? 0,
                        color: AppColors.followUp),
                    LeadData(
                        category: 'Interested',
                        count: data?.interested ?? 0,
                        color: AppColors.interested),
                  ],
                  xValueMapper: (LeadData d, _) => d.category,
                  yValueMapper: (LeadData d, _) => d.count,
                  pointColorMapper: (LeadData d, _) => d.color,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.outside,
                  ),
                  enableTooltip: true,
                  animationDuration: 1500,
                  innerRadius: '60%',
                ),
              ],
              annotations: [
                CircularChartAnnotation(
                  widget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$totalLeads',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Text(
                        'Total',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
