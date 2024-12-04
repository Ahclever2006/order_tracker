import '../data_source/local_data_source.dart';
import '../models/orders.dart';

abstract class OrdersRepository {
  Future<List<OrdersModel>> getOrdersData();
}

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersLocalDateSource _ordersLocalDateSource;
  OrdersRepositoryImpl(this._ordersLocalDateSource);

  @override
  Future<List<OrdersModel>> getOrdersData() => _ordersLocalDateSource.getOrdersData();
}
