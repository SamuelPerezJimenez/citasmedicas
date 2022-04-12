import 'package:flutter/material.dart';

import '../providers/sidemenu_provider.dart';
import '../widgets/sidebar.dart';

class Dashboard extends StatefulWidget {
  final Widget child;
  const Dashboard({Key? key, required this.child}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  @override
  @override
  void initState() {
    super.initState();
    SideMenuProvider.menuController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color(0xffF6F6FB),
        body: Stack(
          children: [
            Row(
              children: [
                if (size.width >= 700) const SideBar(),

                Expanded(
                  child: Column(
                    children: [
                      // Navbar

                      // View
                      Expanded(
                          child: Container(
                        child: widget.child,
                      )),
                    ],
                  ),
                )
                // Contenedor de nuestro view
              ],
            ),
            if (size.width < 700)
              AnimatedBuilder(
                  animation: SideMenuProvider.menuController,
                  builder: (context, _) => Stack(
                        children: [
                          if (SideMenuProvider.isOpen)
                            Opacity(
                              opacity: SideMenuProvider.opacity.value,
                              child: GestureDetector(
                                onTap: () => SideMenuProvider.closeMenu(),
                                child: Container(
                                  width: size.width,
                                  height: size.height,
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          Transform.translate(
                            offset: Offset(SideMenuProvider.movement.value, 0),
                            child: const SideBar(),
                          )
                        ],
                      ))
          ],
        ));
  }
}
