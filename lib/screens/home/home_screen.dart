import 'package:battery_shop/screens/about/about_screen.dart';
import 'package:battery_shop/screens/inverter/inverter_tab.dart';
import 'package:battery_shop/screens/vehicles/widgets/tab_item.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'battery_tab.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              'DashBoard',
              style: TextStyle(
                letterSpacing: 1.2,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AboutScreen.routeName);
                },
                icon: Icon(Icons.info),
              ),
            ],
            bottom: TabBar(
              tabs: [
                TabItem(label: 'Battery', icon: FontAwesomeIcons.carBattery),
                TabItem(label: 'Inverter', icon: Icons.today_sharp),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const BatteryTab(),
              //const Center(child: Text('N/A')),
              InveterTab(),
            ],
          ),
        ),
      ),
    );
  }
}









// class BrandCard extends StatelessWidget {
//   final String? imageUrl;
//   final String name;

//   const BrandCard({Key? key, required this.imageUrl, required this.name})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 4.0,
//         vertical: 4.0,
//       ),
//       child: InkWell(
//         onTap: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => VehicleTypeScreen(),
//             ),
//           );
//         },
//         child: Card(
//           //   elevation: 5,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Spacer(),
//               Container(
//                 height: 100.0,
//                 width: 100.0,
//                 child: DisplayImage(imageUrl: imageUrl),
//               ),
//               Spacer(),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black87),
//                   // color: Color(0xffDDDDDD),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(6.0),
//                     bottomRight: Radius.circular(6.0),
//                   ),
//                 ),
//                 child: Text(
//                   '$name',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     // fontWeight: FontWeight.w500,
//                     letterSpacing: 1.2,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
