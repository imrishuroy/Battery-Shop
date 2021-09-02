import 'package:admin_battery/screens/home/bloc/app_actions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppActions extends StatefulWidget {
  const AppActions({Key? key}) : super(key: key);

  @override
  _AppActionsState createState() => _AppActionsState();
}

class _AppActionsState extends State<AppActions> {
  String dropdownValue = 'Battery DashBoard';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      // value: dropdownValue,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      iconSize: 30,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 0.0,
        color: Colors.redAccent.shade700,
      ),
      onChanged: (String? newValue) {
        print('DropDown value $dropdownValue');
        if (newValue == dropdownValue) {
          context.read<AppActionsBloc>().add(
                ChangeActionStatus(
                  status: ActionStatus.batteryDashBoard,
                ),
              );
        } else {
          context.read<AppActionsBloc>().add(
                ChangeActionStatus(
                  status: ActionStatus.logout,
                ),
              );
        }
      },
      items: <String>['Battery DashBoard', 'Logout']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
