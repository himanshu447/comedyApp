import 'package:comedy/injector.dart' as injector;
import 'package:comedy/utils/route/route_generator.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:flutter/material.dart';

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
      title: AppString.app_name,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeColors(context),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: LandingView(),
    );
  }
}
