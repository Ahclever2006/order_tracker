import 'dart:convert';

import 'package:flutter/services.dart';
import '../../../../core/assets.dart';
import '../models/orders.dart';

abstract class OrdersLocalDateSource {
  Future<List<OrdersModel>> getOrdersData();
}

class OrdersLocalDateSourceImpl implements OrdersLocalDateSource {
  @override
  Future<List<OrdersModel>> getOrdersData() async {
    final String response = await rootBundle.loadString(AppAssets.ordersJson);
    final List<dynamic> ordersMap = json.decode(response);
    return ordersMap.map((e) => OrdersModel.fromMap(e)).toList();
  }
}
