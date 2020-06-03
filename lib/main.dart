import 'package:flutter/material.dart';
import 'package:news_app/screens/news_detail_screen.dart';
import 'package:provider/provider.dart';

import './screens/news_list_screen.dart';
import './screens/home_screen.dart';
import './models/news.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
          value: News(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'News App',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
          ),
          home: HomeScreen(),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            NewsListScreen.routeName: (ctx) => NewsListScreen(),
            NewsDetailScreen.routeName: (ctx) => NewsDetailScreen()
          }),
    );
  }
}
