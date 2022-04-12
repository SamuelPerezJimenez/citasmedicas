import 'package:citas_medicas_app/pages/dashboard.dart';
import 'package:citas_medicas_app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/sidemenu_provider.dart';
import 'services/navigation_service.dart';

void main() async {
  Flurorouter.configureRoutes();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      home: const Dashboard(child: Text('data')),
    );
  }
}