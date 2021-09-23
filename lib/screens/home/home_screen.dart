import '/config/auth_wrapper.dart';
import '/repositories/auth/auth_repo.dart';

import '/screens/battery/battery_dashboard.dart';

import '/screens/home/app_actions.dart';
import '/screens/home/bloc/app_actions_bloc.dart';

import '/screens/vehicle-brands/vehicle_brands_tab.dart';
import '/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_vehicle_brand_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  static Route route() {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) {
        return HomeScreen();
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    try {
      final result = await Services.askToAction(context,
          title: 'Logout', content: 'Do you want to logout ?');
      print('Result $result');
      if (result) {
        await context.read<AuthRepository>().logOut();
        // await FirebaseAuth.instance.signOut();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AuthWrapper.routeName, (route) => false);
      }
    } catch (error) {
      print('Error logout ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AddVehicleBrandScreen(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          // backgroundColor: Color.fromRGBO(0, 141, 82, 1),
          title: const Text('Admin Panel'),
          // bottom: TabBar(
          //   indicatorColor: Colors.white,
          //   tabs: [
          //     const TabItem(label: 'Battery', icon: Icons.battery_full),
          //     // const TabItem(label: 'Inverter', icon: Icons.today_sharp),
          //   ],

          actions: [
            AppActions(),
            const SizedBox(width: 15.0),
          ],
        ),
        body: BlocListener<AppActionsBloc, AppActionsState>(
          listener: (context, state) {
            print('${state.status}');
            if (state.status == ActionStatus.batteryDashBoard) {
              Navigator.of(context).pushNamed(BatteryDashBoard.routeName);
            } else if (state.status == ActionStatus.logout) {
              _logout(context);
            }
          },
          child: VehicleBrandsTab(),
        ),
      ),
    );
  }
}


















// import '/constants/constants.dart';
// import '/repositories/rest-apis/rest_apis_repo.dart';
// import '/screens/amaron/bloc/amaron_bloc.dart';
// import '/screens/battery/battery_dashboard.dart';
// import '/screens/exide/bloc/exide_bloc.dart';
// import '/screens/home/app_actions.dart';
// import '/screens/home/bloc/app_actions_bloc.dart';
// import '/screens/sky/bloc/sky_bloc.dart';
// import '/screens/vehicle-brands/vehicle_brands_tab.dart';
// import '/widgets/tab_item.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'add_vehicle_brand_screen.dart';

// class HomeScreen extends StatelessWidget {
//   static const String routeName = '/home';

//   static Route route() {
//     return PageRouteBuilder(
//       settings: RouteSettings(name: routeName),
//       transitionDuration: const Duration(seconds: 0),
//       pageBuilder: (context, _, __) {
//         return HomeScreen();
//       },
//     );
//   }

//   Future<void> _logout(BuildContext context) async {
//     try {
//       final bool result = await showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Logout'),
//             content: Text('Do you want to logout ?'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(true),
//                 child: Text('Yes', style: TextStyle(color: Colors.red)),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(false),
//                 child: Text(
//                   'No',
//                   style: TextStyle(color: Colors.green),
//                 ),
//               )
//             ],
//           );
//         },
//       );
//       print('Result $result');
//       if (result) {
//         await FirebaseAuth.instance.signOut();
//       }
//     } catch (error) {
//       print('Error logout ${error.toString()}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: DefaultTabController(
//         length: 1,
//         child: Scaffold(
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (_) => AddVehicleBrandScreen(),
//                 ),
//               );
//             },
//             child: const Icon(Icons.add),
//           ),
//           appBar: AppBar(
//             automaticallyImplyLeading: false,
//             centerTitle: true,
//             // backgroundColor: Color.fromRGBO(0, 141, 82, 1),
//             title: const Text('Admin Panel'),
//             bottom: TabBar(
//               indicatorColor: Colors.white,
//               tabs: [
//                 const TabItem(label: 'Battery', icon: Icons.battery_full),
//                 // const TabItem(label: 'Inverter', icon: Icons.today_sharp),
//               ],
//             ),
//             actions: [
//               AppActions(),
//               const SizedBox(width: 15.0),
//             ],
//           ),
//           body: BlocListener<AppActionsBloc, AppActionsState>(
//             listener: (context, state) {
//               print('${state.status}');
//               if (state.status == ActionStatus.batteryDashBoard) {
//                 Navigator.of(context).pushNamed(BatteryDashBoard.routeName);
//               } else if (state.status == ActionStatus.logout) {
//                 _logout(context);
//               }
//             },
//             child: TabBarView(
//               children: [
//                 const VehicleBrandsTab(),
//                 // MultiBlocProvider(providers: [
//                 //   BlocProvider<AmaronBloc>(
//                 //     create: (context) => AmaronBloc(
//                 //       path: Urls.amaronUrl,
//                 //       repository: context.read<RestApisRepository>(),
//                 //     ),
//                 //   ),
//                 //   BlocProvider<SkyBloc>(
//                 //     create: (context) => SkyBloc(
//                 //       path: Urls.skyUrl,
//                 //       restApisRepository: context.read<RestApisRepository>(),
//                 //     ),
//                 //   ),
//                 //   BlocProvider<ExideBloc>(
//                 //     create: (context) => ExideBloc(
//                 //       restApisRepository: context.read<RestApisRepository>(),
//                 //     ),
//                 //   ),
//                 // ], child: const BatteryDashBoard()),
//                 // const Center(child: Text('N/A')),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
