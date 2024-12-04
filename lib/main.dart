import 'package:flutter/material.dart';
import 'package:orders_tracker_app/res/app_colors.dart';
import 'features/orders/presentation/pages/orders_graph_screen.dart';
import 'features/orders/presentation/pages/orders_metrics_screen.dart';
import 'shared_widgets/button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DefaultButton(
              margin: const EdgeInsets.all(16.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
              backgroundColor: AppColors.PRIMARY_COLOR_DARK,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OrdersMetricsScreen()));
              },
              label: "Metrics",
            ),
            DefaultButton(
              padding:
                  const EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    // ignore: prefer_const_constructors
                    builder: (context) => OrdersGraphScreen()));
              },
              label: "Graphs",
            )
          ],
        ),
      ),
    );
  }
}
