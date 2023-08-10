import 'package:flutter/material.dart';
import 'package:libra_read/constant/color_schemes.g.dart';
import 'package:libra_read/model/database/database.dart';
import 'package:libra_read/view/main.dart';
import 'package:provider/provider.dart';
import 'provider/app_state.dart';
import 'package:google_fonts/google_fonts.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppState(), // 状態管理
        ),
        Provider(
          create: (context) => AppDatabase(),
        )
      ],
      child: MaterialApp(
        title: 'LIBRA READ', // アプリタイトル
        theme: ThemeData(
          // アプリのテーマカラーや部品設定
          useMaterial3: true,
          colorScheme: lightColorScheme,
          textTheme: GoogleFonts.sawarabiGothicTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: GoogleFonts.sawarabiGothicTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const MainAppView(),
      ),
    );
  }
}
