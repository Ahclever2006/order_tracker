part of 'graph_cubit.dart';

enum OrderStateStatus {
  initial,
  loading,
  loaded,
  error,
}

extension OrderStateX on OrderGraphState {
  bool get isInitial => status == OrderStateStatus.initial;
  bool get isLoading => status == OrderStateStatus.loading;
  bool get isLoaded => status == OrderStateStatus.loaded;
  bool get isError => status == OrderStateStatus.error;
}

@immutable
class OrderGraphState {
  final OrderStateStatus status;
  final List<OrdersModel>? orders;
  final Map<String, int> ordersPerDay;
  final String? errorMessage;
  const OrderGraphState({
    this.status = OrderStateStatus.initial,
    this.orders,
    this.errorMessage,
    this.ordersPerDay = const {},
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        other is OrderGraphState &&
        other.status == status &&
        other.errorMessage == errorMessage &&
        other.ordersPerDay == ordersPerDay &&
        other.orders == orders;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      orders.hashCode ^
      ordersPerDay.hashCode;

  OrderGraphState copyWith(
      {OrderStateStatus? status,
      List<OrdersModel>? orders,
      Map<String, int>? ordersPerDay,
      String? errorMessage}) {
    return OrderGraphState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      orders: orders ?? this.orders,
      ordersPerDay: ordersPerDay ?? this.ordersPerDay,
    );
  }
}
