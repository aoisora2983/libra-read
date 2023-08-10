import 'package:flutter/material.dart';
import 'package:libra_read/constant/constant.dart';
import 'package:libra_read/model/database/database.dart';
import 'package:libra_read/view/components/read_pie_chart.dart';
import 'package:libra_read/view/components/text_edit_dialog.dart';
import 'package:libra_read/view/page/history_read_goal.dart';
import 'package:libra_read/view/secondary.dart';
import 'package:provider/provider.dart';

// 読書目標
class ReadGoal extends StatefulWidget {
  const ReadGoal({super.key});

  @override
  State<StatefulWidget> createState() => ReadGoalState();
}

class ReadGoalState extends State<ReadGoal> {
  TextEditingController controller = TextEditingController(text: '0');
  int goal = 0;

  @override
  Widget build(BuildContext context) {
    double buttonWidth = (MediaQuery.of(context).size.width - 64) / 2;
    if (buttonWidth > 200) {
      // 最大値設定
      buttonWidth = 200;
    }
    if (buttonWidth < 160) {
      // 最小値設定
      buttonWidth = MediaQuery.of(context).size.width - 64;
    }

    return FutureBuilder(
      future: getThisGoal(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          int now = snapshot.data['now'];
          goal = snapshot.data['goal'];
          double rate = (now / goal) * 100;
          if (!rate.isInfinite && !rate.isNaN) {
            String rateStr = rate.toInt().toString();

            return Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      child: Column(
                        children: [
                          Text(
                            "$rateStr%",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            "目標：${goal.toString().padLeft(3, ' ')}冊",
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      child: SizedBox(
                        height: 350,
                        child: ReadCompletePieChart(
                          goalReadCount: snapshot.data['goal'],
                          nowReadCount: snapshot.data['now'],
                        ),
                      ),
                    )
                  ],
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    SizedBox(
                      width: buttonWidth,
                      child:
                          renderSetGoalBUtton(context, snapshot.data['goal']),
                    ),
                    SizedBox(
                      width: buttonWidth,
                      child: renderHistoryGoalBUtton(context),
                    ),
                  ],
                )
              ],
            );
          }
        }

        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 36, horizontal: 16),
              child: Center(
                child: Text('今月の読書目標が設定されていません。\n設定してみましょう！'),
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                SizedBox(
                  width: buttonWidth,
                  child: renderSetGoalBUtton(context, 0),
                ),
                SizedBox(
                  width: buttonWidth,
                  child: renderHistoryGoalBUtton(context),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  onSetGoal() {
    setState(() {
      goal = int.parse(controller.text);
    });
  }

  // 目標設定ボタン
  Widget renderSetGoalBUtton(context, int goal) {
    return ElevatedButton(
      onPressed: () {
        onPressedSetGoal(
          context,
          goal,
        );
      },
      child: const Text(
        "目標を設定する",
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget renderHistoryGoalBUtton(context) {
    return ElevatedButton(
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return const SecondaryView(
              pageIndex: SecondaryPage.pageHistoryReadGoal,
              page: HistoryReadGoalView(),
            );
          }),
        );
      },
      child: const Text(
        "履歴を見る",
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  // 今月の目標と、読了状況取得
  Future<Map<String, int>> getThisGoal(context) async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    final history = await database.historiesReadDao.getHistoryRead();
    final goal = await database.goalsReadDao.getThisGoal();

    int goalVal = 0;
    int nowVal = 0;

    if (goal != null) {
      goalVal = goal.goal;
    }

    if (history != null) {
      nowVal = history.readCount;
    }

    return {'goal': goalVal, 'now': nowVal};
  }

  Future<int?> onPressedSetGoal(
    BuildContext context,
    int? value,
  ) {
    return showDialog<int>(
      context: context,
      builder: (context) {
        return TextEditingDialog(
          text: value.toString(),
          keywordController: controller,
          onSetGoal: onSetGoal,
        );
      },
    );
  }
}
