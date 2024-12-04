import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../../../data/models/orders.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../data/repository/orders_repository.dart';
part 'metrics_state.dart';

class OrdersMetricsCubit extends BaseCubit<OrdersMetricsState> {
  final OrdersRepository ordersRepository;
  OrdersMetricsCubit({required this.ordersRepository})
      : super(const OrdersMetricsState());

  Future<void> getOrdersMetrics() async {
    emit(state.copyWith(status: OrderStateStatus.loading));
    try {
      final orders = await ordersRepository.getOrdersData();
      final totalCounts = orders.length;
      final totalReturns = orders
          .where((order) => order.status?.toLowerCase() == 'returned')
          .length;
      final averageSale = formatPrice(calculateAverageSale(orders));
      emit(state.copyWith(
          status: OrderStateStatus.loaded,
          totalCounts: totalCounts,
          totalReturns: totalReturns,
          averageSale: averageSale));
    } catch (e) {
      emit(state.copyWith(
          status: OrderStateStatus.error, errorMessage: e.toString()));
    }
  }

  double calculateAverageSale(List<OrdersModel> orders) {
    if (orders.isEmpty) return 0.0;

    double totalPrice =
        orders.fold(0.0, (sum, order) => sum + parsePrice(order.price));
    double average = totalPrice / orders.length;

    return average;
  }

  double parsePrice(String? priceString) {
    if (priceString == null) return 0.0;
    return double.parse(priceString.replaceAll('\$', '').replaceAll(',', ''));
  }

  String formatPrice(double price) {
    final NumberFormat formatter =
        NumberFormat.currency(locale: 'en_US', symbol: '\$');
    return formatter.format(price);
  }
}
