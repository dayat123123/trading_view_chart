import 'package:flutter/material.dart';
import 'package:trading_view_chart/features/trading_view_chart/trading_view_chart_desktop.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Trading View")),
        body: const ExampleBrowser());
  }
}
