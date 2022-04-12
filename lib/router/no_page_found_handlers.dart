import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';

import '../providers/sidemenu_provider.dart';

class NoPageFoundHandlers {
  static Handler noPageFound = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl('/404');

    return Container();
  });
}
