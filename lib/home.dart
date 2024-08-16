import 'package:flutter/material.dart';
import 'package:trading_view_chart/features/trading_view_chart/trading_view_chart_html.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Trading View")),
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: double.infinity,
          child: const Column(
            children: [
              Expanded(child: TradingViewChartHtml()),
              SizedBox(height: 30)
            ],
          ),
        ));
  }
}
