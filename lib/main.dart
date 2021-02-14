import 'package:flutter/material.dart';
import 'package:xipel/core/utilities/analytics.dart';
import 'package:xipel/features/pages/love_generator_page.dart';

Future<void> main() async {
  await Analytics.analytics.logAppOpen();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.centerLeft,
            child: Text("Xipel", style: TextStyle(
              color: Colors.black,
            ),),
          ),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: LoveGeneratorPage(),
        ),
      ),
    );
  }
}
