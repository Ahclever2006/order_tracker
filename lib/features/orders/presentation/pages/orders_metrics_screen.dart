import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/orders_metrics/metrics_cubit.dart';
import '../../../../res/app_colors.dart';
import '../../../../di/injector.dart';

class OrdersMetricsScreen extends StatelessWidget {
  const OrdersMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector().ordersMetrics..getOrdersMetrics(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Orders Metrics"),
        ),
        body: BlocConsumer<OrdersMetricsCubit, OrdersMetricsState>(
            builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildCard("Total Orders", "${state.totalCounts}", context),
                _buildCard(
                    "Total Returned Orders", "${state.totalReturns}", context),
                _buildCard("Average Sales", state.averageSale, context),
              ],
            ),
          );
        }, listener: (context, state) {
          if (state.isError) {
            log(state.errorMessage.toString());
          }
        }),
      ),
    );
  }

  Widget _buildCard(String title, String value, BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            height: MediaQuery.sizeOf(context).height * 0.1,
            child: Card(
              elevation: 1.2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8.0,
                    margin: const EdgeInsets.only(right: 10.0),
                    decoration: const BoxDecoration(
                      color: AppColors.PRIMARY_COLOR,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    height: MediaQuery.sizeOf(context).height * 0.1,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(value)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
