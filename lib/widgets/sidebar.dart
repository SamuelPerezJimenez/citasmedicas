import 'package:citas_medicas_app/widgets/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/sidemenu_provider.dart';
import '../router/router.dart';
import '../services/navigation_service.dart';
import 'logo.dart';
import 'menu_item.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Logo(),
          const SizedBox(height: 50),
          const TextSeparator(text: 'main'),
          MenuItem(
            text: 'Dashboard',
            icon: Icons.dashboard,
            onPressed: () => navigateTo(Flurorouter.dashboardRoute),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
          ),
          MenuItem(
              text: 'Citas',
              icon: Icons.calendar_month,
              onPressed: () => navigateTo(Flurorouter.appointmentRoute),
              isActive:
                  sideMenuProvider.currentPage == Flurorouter.dashboardRoute),
          MenuItem(
              text: 'Pacientes',
              icon: Icons.show_chart_outlined,
              isActive:
                  sideMenuProvider.currentPage == Flurorouter.patientsRoute,
              onPressed: () => navigateTo(Flurorouter.patientsRoute)),
          MenuItem(
            text: 'Doctores',
            icon: Icons.layers_outlined,
            onPressed: () => navigateTo(Flurorouter.doctorsRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.doctorsRoute,
          ),
          MenuItem(
              text: 'Configuración', icon: Icons.settings, onPressed: () {}),
          const SizedBox(height: 30),
          // const TextSeparator(text: 'UI Elements'),
          // MenuItem(
          //   text: 'Icons',
          //   icon: Icons.list_alt_outlined,
          //   onPressed: () => navigateTo(Flurorouter.iconsRoute),
          //   isActive: sideMenuProvider.currentPage == Flurorouter.iconsRoute,
          // ),
          // MenuItem(
          //     text: 'Marketing',
          //     icon: Icons.mark_email_read_outlined,
          //     onPressed: () {}),
          // MenuItem(
          //     text: 'Campaign',
          //     icon: Icons.note_add_outlined,
          //     onPressed: () {}),
          // MenuItem(
          //   text: 'Black',
          //   icon: Icons.post_add_outlined,
          //   onPressed: () => navigateTo(Flurorouter.blankRoute),
          //   isActive: sideMenuProvider.currentPage == Flurorouter.blankRoute,
          // ),
          // const SizedBox(height: 50),
          const TextSeparator(text: 'Exit'),
          MenuItem(
              text: 'Cerrar Sesión',
              icon: Icons.exit_to_app_outlined,
              onPressed: () {
                //Provider.of<AuthProvider>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      gradient: LinearGradient(colors: [
        Color(0xff0D68A8),
        Color(0xff0D68A8),
      ]),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
