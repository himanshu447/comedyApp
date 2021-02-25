import 'package:comedy/utils/route/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:comedy/injector.dart' as injector;

import 'config/apptheme.dart';
import 'feacture/landing/presentation/page/landing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injector.init();
  runApp(ComedyApp());
}

class ComedyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeColors(context),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: LandingView(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
