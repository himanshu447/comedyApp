import 'package:comedy/injector.dart' as injector;
import 'package:comedy/utils/route/route_generator.dart';
import 'package:flutter/material.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: LandingView(),
    );
  }
}
