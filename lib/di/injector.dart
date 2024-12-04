import '../features/orders/data/data_source/local_data_source.dart';
import '../features/orders/data/repository/orders_repository.dart';
import '../features/orders/presentation/cubit/orders_metrics/metrics_cubit.dart';

import '../features/orders/presentation/cubit/orders_graph/graph_cubit.dart';

class Injector {
  final _flyweightMap = <String, dynamic>{};
  static final _singleton = Injector._internal();

  Injector._internal();
  factory Injector() => _singleton;

  OrdersGraphCubit get ordersGraph =>
      OrdersGraphCubit(ordersRepository: ordersRepository);

  OrdersMetricsCubit get ordersMetrics =>
      OrdersMetricsCubit(ordersRepository: ordersRepository);
      
  OrdersRepository get ordersRepository => _flyweightMap['ordersRepository'] ??=
      OrdersRepositoryImpl(ordersLocalDataSource);
  OrdersLocalDateSource get ordersLocalDataSource =>
      _flyweightMap['ordersLocalDataSource'] ??= OrdersLocalDateSourceImpl();
}
