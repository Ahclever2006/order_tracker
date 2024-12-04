part of 'metrics_cubit.dart';

enum OrderStateStatus {
  initial,
  loading,
  loaded,
  error,
}

extension OrderStateX on OrdersMetricsState {
  bool get isInitial => status == OrderStateStatus.initial;
  bool get isLoading => status == OrderStateStatus.loading;
  bool get isLoaded => status == OrderStateStatus.loaded;
  bool get isError => status == OrderStateStatus.error;
}

@immutable
class OrdersMetricsState {
  final OrderStateStatus status;
  final int totalCounts;
  final String averageSale;
  final int totalReturns;
  final String? errorMessage;
  const OrdersMetricsState({
    this.status = OrderStateStatus.initial,
    this.totalCounts = 0,
    this.averageSale = "0.00",
    this.totalReturns = 0,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        other is OrdersMetricsState &&
        other.status == status &&
        other.errorMessage == errorMessage &&
        other.totalCounts == totalCounts &&
        other.averageSale == averageSale &&
        other.totalReturns == totalReturns;
  }

  @override
  int get hashCode =>
      totalCounts.hashCode ^ averageSale.hashCode ^ totalReturns.hashCode;

  OrdersMetricsState copyWith(
      {OrderStateStatus? status,
      int? totalCounts,
      String? averageSale,
      int? totalReturns,
      String? errorMessage}) {
    return OrdersMetricsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      totalCounts: totalCounts ?? this.totalCounts,
      averageSale: averageSale ?? this.averageSale,
      totalReturns: totalReturns ?? this.totalReturns,
    );
  }
}
