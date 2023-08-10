import 'package:flutter/material.dart';
import 'package:libra_read/model/database/database.dart';
import 'package:provider/provider.dart';

class HistoryReadGoalView extends StatefulWidget {
  const HistoryReadGoalView({super.key});

  @override
  State<HistoryReadGoalView> createState() => HistoryReadGoalViewState();
}

class HistoryReadGoalViewState extends State<HistoryReadGoalView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getHistoryList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return SingleChildScrollView(
            child: Column(
              children: snapshot.data,
            ),
          );
        }
        return const Center(child: Text('履歴がありません。\n目標を設定してみましょう！'));
      },
    );
  }

  Future<List> getHistoryList() async {
    DateTime now = DateTime.now();
    final database = Provider.of<AppDatabase>(context, listen: false);
    List<Widget> resultList = [];

    List<GoalRead> goalList = await database.goalsReadDao.getAllGoal();
    List<HistoryRead> tmpHistoryList =
        await database.historiesReadDao.getAllHistory();
    Map<String, HistoryRead> historyList = {};
    for (HistoryRead historyRead in tmpHistoryList) {
      String key = historyRead.readDate.year.toString() +
          historyRead.readDate.month.toString();

      historyList[key] = historyRead;
    }

    for (GoalRead goalRead in goalList) {
      String key =
          goalRead.setDate.year.toString() + goalRead.setDate.month.toString();
      int goalCnt = goalRead.goal;
      int readCnt = 0;
      if (historyList.containsKey(key)) {
        readCnt = historyList[key]!.readCount;
      }

      String isGoal = "目標達成！";
      String comment = "おめでとうございます！目標を達成しました。";
      if (readCnt < goalCnt) {
        // 読んだ数が目標数より小さければ未達
        isGoal = "目標未達成";
        comment = "目標は次回に持ち越しましょう。\n読書は自分のペースで楽しむことが一番です。";

        // 今月の話なら挑戦中表記
        if (goalRead.setDate.year == now.year &&
            goalRead.setDate.month == now.month) {
          int bookNum = goalCnt - readCnt;
          isGoal = "挑戦中！";
          comment = "あと$bookNum冊です。無理せず少しずつ読んでいきましょう。";
        }
      }

      resultList.add(
        SizedBox(
          child: Card(
            margin: EdgeInsets.only(top: 8, right: 16, left: 16),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    // 成功・未達・挑戦中のイメージ
                    width: 100,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${goalRead.setDate.year}年${goalRead.setDate.month}月',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          isGoal,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '$readCnt / $goalCnt 冊',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          comment,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return resultList;
  }
}
