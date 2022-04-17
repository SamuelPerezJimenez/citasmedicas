import 'package:citas_medicas_app/pages/dashboard.dart';
import 'package:citas_medicas_app/pages/doctors.dart';
import 'package:citas_medicas_app/pages/patients.dart';
import 'package:citas_medicas_app/router/router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/sidemenu_provider.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(handlerFunc: (context, params) {
    return const Dashboard(
      child: Text('data'),
    );

    // final authProvider = Provider.of<AuthProvider>(context!);
    // Provider.of<SideMenuProvider>(context, listen: false)
    //   .setCurrentPageUrl( Flurorouter.dashboardRoute );

    // if ( authProvider.authStatus == AuthStatus.authenticated )
    //   return DashboardView();
    // else
    //   return LoginView();
  });

  static Handler doctors = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl(Flurorouter.doctorsRoute);
    return const Dashboard(child: Doctors());
  });

  static Handler patients = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl(Flurorouter.patientsRoute);
    return const Dashboard(child: Patients());
  });
}
