import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../../../di/injector.dart';
import '../cubit/orders_graph/graph_cubit.dart';

class OrdersGraphScreen extends StatelessWidget {
  const OrdersGraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector().ordersGraph..getOrdersGraphData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Orders Graph"),
        ),
        body: BlocConsumer<OrdersGraphCubit, OrderGraphState>(
          builder: (context, state) {
            if (state.isLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildChart(state.ordersPerDay),
              );
            } else if (state.isError) {
              return Center(
                child: Text(
                  state.errorMessage ?? "An error occurred",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
          listener: (context, state) {
            if (state.isError) {
              log(state.errorMessage ?? "Error occurred in graph cubit");
            }
          },
        ),
      ),
    );
  }

  Widget _buildChart(Map<String, int> data) {
    // Step 1: Aggregate data by month
    final Map<String, double> aggregatedData = {};

    data.forEach((key, value) {
      final month =
          DateFormat('MMM').format(DateTime.parse(key)); // e.g., "Jan"
      if (aggregatedData.containsKey(month)) {
        aggregatedData[month] = aggregatedData[month]! + value.toDouble();
      } else {
        aggregatedData[month] = value.toDouble();
      }
    });

    // Step 2: Sort the months (Jan, Feb, Mar, ...)
    final sortedMonths = aggregatedData.keys.toList()
      ..sort((a, b) {
        final aDate = DateFormat('MMM').parse(a);
        final bDate = DateFormat('MMM').parse(b);
        return aDate.compareTo(bDate);
      });

    // Step 3: Extract counts in sorted order
    final counts = sortedMonths.map((month) => aggregatedData[month]!).toList();

    // Step 4: Log the aggregated data for debugging
    log('Months: $sortedMonths');
    log('Counts: $counts');

    // Step 5: Build the chart
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: List.generate(sortedMonths.length, (index) {
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: counts[index],
                width: 16,
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.blue], // Gradient colors
                  begin: Alignment.bottomCenter, // Start of the gradient
                  end: Alignment.topCenter, // End of the gradient
                ),
              ),
            ],
          );
        }),
        minY: 0, // Minimum value for y-axis
        maxY: 20, // Maximum value for y-axis
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 10, // Interval between y-axis labels
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < sortedMonths.length) {
                  return Text(
                    sortedMonths[value.toInt()],
                    style: const TextStyle(fontSize: 10),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey),
        ),
      ),
    );
  }
}
