import 'package:flutter/foundation.dart';
import '../../../data/models/orders.dart';
import '../../../../../core/abstract/base_cubit.dart';
import '../../../data/repository/orders_repository.dart';
part 'graph_state.dart';

class OrdersGraphCubit extends BaseCubit<OrderGraphState> {
  final OrdersRepository ordersRepository;
  OrdersGraphCubit({required this.ordersRepository})
      : super(const OrderGraphState());

  Future<void> getOrdersGraphData() async {
    emit(state.copyWith(status: OrderStateStatus.loading));
    try {
      final orders = await ordersRepository.getOrdersData();

      emit(state.copyWith(
        status: OrderStateStatus.loaded,
        ordersPerDay: getOrdersPerDay(orders),
      ));
    } catch (e) {
      emit(state.copyWith(
          status: OrderStateStatus.error, errorMessage: e.toString()));
    }
  }

  Map<String, int> getOrdersPerDay(List<OrdersModel> orders) {
    Map<String, int> timeOrderCount = {};
    for (var entry in orders) {
      String timestamp = entry.registered!;
      if (timeOrderCount.containsKey(timestamp)) {
        timeOrderCount[timestamp] = timeOrderCount[timestamp]! + 1;
      } else {
        timeOrderCount[timestamp] = 1;
      }
    }
    return timeOrderCount;
  }
}
