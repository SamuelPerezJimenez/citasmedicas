import 'package:citas_medicas_app/router/dashborad_handlers.dart';
import 'package:fluro/fluro.dart';

import 'no_page_found_handlers.dart';

class Flurorouter {
  static final FluroRouter router = new FluroRouter();

  static String rootRoute = '/';

  // Auth Router
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';

  // Dashboard
  static String dashboardRoute = '/dashboard';
  static String iconsRoute = '/dashboard/icons';
  static String blankRoute = '/dashboard/blank';
  static String doctorsRoute = '/dashboard/doctors';
  static String patientsRoute = '/dashboard/patients';
  static String appointmentRoute = '/dashboard/appointments';

  static String usersRoute = '/dashboard/users';
  static String userRoute = '/dashboard/users/:uid';

  static void configureRoutes() {
    // // Auth Routes
    // router.define( rootRoute, handler: AdminHandlers.login, transitionType: TransitionType.none );
    // router.define( loginRoute, handler: AdminHandlers.login, transitionType: TransitionType.none );
    // router.define( registerRoute, handler: AdminHandlers.register, transitionType: TransitionType.none );

    // // Dashboard

    router.define(dashboardRoute,
        handler: DashboardHandlers.dashboard,
        transitionType: TransitionType.fadeIn);

    router.define(doctorsRoute,
        handler: DashboardHandlers.doctors,
        transitionType: TransitionType.fadeIn);

    router.define(appointmentRoute,
        handler: DashboardHandlers.appointment,
        transitionType: TransitionType.fadeIn);

    router.define(patientsRoute,
        handler: DashboardHandlers.patients,
        transitionType: TransitionType.fadeIn);
    // router.define( blankRoute, handler: DashboardHandlers.blank, transitionType: TransitionType.fadeIn );
    // router.define( categoriesRoute, handler: DashboardHandlers.categories, transitionType: TransitionType.fadeIn );
    // router.define( iconsRoute, handler: DashboardHandlers.icons, transitionType: TransitionType.fadeIn );

    // // users
    // router.define( usersRoute, handler: DashboardHandlers.users, transitionType: TransitionType.fadeIn );
    // router.define( userRoute, handler: DashboardHandlers.user, transitionType: TransitionType.fadeIn );

    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
