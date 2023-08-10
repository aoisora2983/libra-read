import 'package:flutter/material.dart';
import 'package:libra_read/model/database/database.dart';
import 'package:provider/provider.dart';

class ReadTotal extends StatelessWidget {
  const ReadTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context, listen: false);
    final mediaWidth = MediaQuery.of(context).size.width;
    double imageWidth = 120;

    return FutureBuilder(
      future: database.historiesReadDao.getTotalRead(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        int total = 0;
        if (snapshot.hasData && snapshot.data > 0) {
          total = snapshot.data;
        }

        return SizedBox(
          height: 200,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: (mediaWidth * 0.5) - 60,
                top: 10,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                  ),
                ),
              ),
              Positioned(
                left:
                    (mediaWidth * 0.5) - (imageWidth * 1.3), // 半分の位置に配置して少しずらす
                bottom: -5,
                child: Image(
                  image: const AssetImage('assets/images/stack_books.png'),
                  width: imageWidth,
                ),
              ),
              Positioned(
                left: ((mediaWidth * 0.5) - (imageWidth * 1.3)) +
                    110, // 本の位置から右にずらす
                top: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: ((mediaWidth * 0.5) - (imageWidth * 1.3)) +
                          110, // 本の位置から右にずらす
                      child: Row(
                        children: [
                          Text(
                            total.toString().padLeft(4),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const Text(
                            " 冊",
                            style: TextStyle(fontSize: 12, height: 3.5),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: ((mediaWidth * 0.5) - (imageWidth * 1.3)) + 150,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          getComment(total),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String getComment(int total) {
    String comment = 'まずは読みたい本、\n読んだ本を登録してみましょう！';

    if (total > 0) {
      comment = '読書が楽しくなってきましたか？\n自分の興味や好みに合った本を探してみましょう！';
    }

    if (total > 10) {
      comment = '読書の習慣ができてきました。\nさまざまなジャンルや作家の本に挑戦してみましょう！';
    }

    if (total > 40) {
      comment = '素晴らしいです！\n読書家と呼べるレベルに達しました。';
    }

    if (total > 100) {
      comment = '読書の達人と言えるでしょう。\n本から得た知識や感動を、自分の言葉で表現してみましょう。';
    }

    if (total > 150) {
      comment = '読書の名人と呼べるでしょう。\n本から学んだことや考えたことを、他の人と共有してみましょう。';
    }

    if (total > 200) {
      comment = '読書の神様と呼ばれるでしょう。\n本からインスピレーションを得て、自分の作品を創造してみましょう。';
    }

    return comment;
  }
}
