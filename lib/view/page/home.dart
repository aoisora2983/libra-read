import 'package:flutter/material.dart';
import 'package:libra_read/view/components/read_bar_chart.dart';
import 'package:libra_read/view/components/read_goal.dart';
import 'package:libra_read/view/components/read_total.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        children: [
          Column(
            children: [
              Text(
                "総読書数",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const ReadTotal(),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  "今月の読書状況",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const ReadGoal(),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  "月ごとの読書状況",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: MonthlyReadBarChart(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
