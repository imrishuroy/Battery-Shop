import 'dart:js';

import 'package:flutter/material.dart';

class SetBatteryPriority extends StatelessWidget {
  static const String routeName = 'set-priority';
  const SetBatteryPriority({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
        settings: RouteSettings(name: routeName),
        pageBuilder: (context, _, __) {
          return SetBatteryPriority();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
