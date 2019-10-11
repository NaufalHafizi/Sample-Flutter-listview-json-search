import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Homepage.dart';
import 'Provider.dart';


void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: Allscreen(),),
    ],
    child: new MyApp(),
  )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
