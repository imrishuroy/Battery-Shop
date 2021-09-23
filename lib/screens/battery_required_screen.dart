// import '/constants/constants.dart';
// import '/config/paths.dart';
// import '/enums/enums.dart';
// import '/models/battery_required.dart';
// import '/repositories/battery/battery_repository.dart';
// import '/screens/amaron/bloc/amaron_bloc.dart';
// import '/screens/battery/add_battery_to_vehicle.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:url_launcher/url_launcher.dart';

// List<BatteryRequired> batteries = [
//   BatteryRequired(
//     name: 'EXIDE',
//     imageUrl: 'https://m.media-amazon.com/images/I/61OtrnWqhAL._SL1022_.jpg',
//   ),
//   BatteryRequired(
//     name: 'Amaron',
//     imageUrl:
//         'https://5.imimg.com/data5/DD/YH/MY-26895427/amaron-automotive-batteries-500x500.jpg',
//   ),
// ];

// class BatteryRequiredScreen extends StatelessWidget {
//   final String? vehicleBrandId;
//   final FuelType fuelType;
//   final String? vehicleId;
//   final String vehicleType;

//   const BatteryRequiredScreen({
//     Key? key,
//     required this.vehicleBrandId,
//     required this.fuelType,
//     required this.vehicleId,
//     required this.vehicleType,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).push(
//             PageRouteBuilder(
//               pageBuilder: (context, _, __) => BlocProvider<AmaronBloc>(
//                 create: (context) => AmaronBloc(
//                     repository: context.read<BatteryRepository>(),
//                     path: Paths.amaron),
//                 child: AddBatteryToVehicle(
//                   vehicleBrandId: vehicleBrandId,
//                   vehicleId: vehicleId,
//                   fuelType: fuelType,
//                   vehicleType: vehicleType,
//                 ),
//               ),
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Battery Required'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: AnimationLimiter(
//               child: ListView.builder(
//                 itemCount: batteries.length,
//                 itemBuilder: (context, index) {
//                   final battery = batteries[index];
//                   return AnimationConfiguration.staggeredList(
//                     position: index,
//                     duration: const Duration(milliseconds: 375),
//                     child: SlideAnimation(
//                       verticalOffset: 50.0,
//                       child: FadeInAnimation(
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(14.0, 20.0, 14.0, 3.0),
//                           child: Container(
//                             child: Column(
//                               children: [
//                                 Row(
//                                   //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       children: [
//                                         Container(
//                                           height: 80.0,
//                                           width: 80.0,
//                                           child: Image.network(
//                                               battery.imageUrl ?? errorImage),
//                                         ),
//                                         const SizedBox(height: 5.0),
//                                         Text(
//                                           '₹9999',
//                                           style: TextStyle(
//                                             fontSize: 16.0,
//                                             fontWeight: FontWeight.w600,
//                                             letterSpacing: 1.2,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     const SizedBox(width: 15.0),
//                                     Container(
//                                       width: 175,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             '${battery.name}',
//                                             style: TextStyle(
//                                               fontSize: 16.0,
//                                               fontWeight: FontWeight.w600,
//                                               letterSpacing: 1.0,
//                                             ),
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                           const SizedBox(height: 2.0),
//                                           Text(
//                                             'Model TT1001',
//                                             style: TextStyle(
//                                               color: Colors.grey.shade700,
//                                             ),
//                                           ),
//                                           Text(
//                                             'AH1 - 100AH',
//                                             style: TextStyle(
//                                               color: Colors.grey.shade700,
//                                             ),
//                                           ),
//                                           const SizedBox(height: 30.0),
//                                           // Text('Dealer Price'),
//                                           Text('( Excluding GST )')
//                                         ],
//                                       ),
//                                     ),
//                                     Spacer(),
//                                     Padding(
//                                       padding:
//                                           const EdgeInsets.only(right: 5.0),
//                                       child: InkWell(
//                                         onTap: () {
//                                           launch('tel://1234567890');
//                                         },
//                                         child: Column(
//                                           children: [
//                                             Icon(
//                                               Icons.call,
//                                               color: Colors.green,
//                                             ),
//                                             const SizedBox(height: 6.0),
//                                             Text('Call'),
//                                             Text('Distributor')
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 const SizedBox(height: 4.5),
//                                 Divider(
//                                   color: Colors.grey.shade800,
//                                 )
//                               ],
//                             ),
//                           ),

//                           // ListTile(
//                           //   leading: Container(
//                           //     height: 90.0,
//                           //     width: 90.0,
//                           //     child: Column(
//                           //       children: [
//                           //         CachedNetworkImage(
//                           //           imageUrl: battery.imageUrl!,
//                           //           fit: BoxFit.fill,
//                           //         ),
//                           //         Text('9999')
//                           //       ],
//                           //     ),
//                           //   ),
//                           //   title: Text(
//                           //     '${battery.name}',
//                           //     style: TextStyle(fontSize: 16.0),
//                           //   ),
//                           //   subtitle: Column(
//                           //     crossAxisAlignment: CrossAxisAlignment.start,
//                           //     children: [
//                           //       Text('100AH'),
//                           //       const SizedBox(height: 1.0),
//                           //       Text(
//                           //         'IAB991818111',
//                           //         style: TextStyle(
//                           //           fontSize: 14.0,
//                           //           color: Colors.grey.shade700,
//                           //         ),
//                           //       ),
//                           //     ],
//                           //   ),
//                           //   trailing: TextButton.icon(
//                           //     onPressed: () {
//                           //       launch('tel://1234567890');
//                           //     },
//                           //     icon: Icon(
//                           //       Icons.call,
//                           //       size: 15.0,
//                           //     ),
//                           //     label: Text('Contact'),
//                           //   ),
//                           // ),

//                           //  Card(
//                           //   child: Row(
//                           //     children: [
//                           //       Container(
//                           //         decoration: BoxDecoration(
//                           //             borderRadius: BorderRadius.circular(6.0)),
//                           //         height: 100.0,
//                           //         width: 100.0,
//                           //         child: ClipRRect(
//                           //           borderRadius: BorderRadius.circular(6.0),
//                           //           child: CachedNetworkImage(
//                           //             imageUrl: battery.imageUrl!,
//                           //           ),
//                           //         ),
//                           //       ),
//                           //       const SizedBox(width: 10.0),
//                           //       Column(
//                           //         crossAxisAlignment: CrossAxisAlignment.start,
//                           //         children: [
//                           //           Text(
//                           //             '${battery.name}',
//                           //             style: TextStyle(fontSize: 17.0),
//                           //           ),
//                           //           const SizedBox(height: 6.0),
//                           //           Text(
//                           //             '100AH',
//                           //             style: TextStyle(
//                           //               fontSize: 15.0,
//                           //               color: Colors.grey.shade700,
//                           //             ),
//                           //           ),
//                           //           const SizedBox(height: 1.0),
//                           //           Row(
//                           //             children: [
//                           //               Text(
//                           //                 ' IAB991818111',
//                           //                 style: TextStyle(
//                           //                   fontSize: 14.0,
//                           //                   color: Colors.grey.shade700,
//                           //                 ),
//                           //               ),
//                           //             ],
//                           //           )
//                           //         ],
//                           //       )
//                           //     ],
//                           //   ),
//                           // )

//                           // Stack(
//                           //   children: [
//                           //     Card(
//                           //       child: Container(
//                           //         padding: EdgeInsets.symmetric(
//                           //           horizontal: 12.0,
//                           //           vertical: 7.0,
//                           //         ),
//                           //         child: Row(
//                           //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           //           children: [
//                           //             Column(
//                           //               mainAxisAlignment:
//                           //                   MainAxisAlignment.spaceEvenly,
//                           //               crossAxisAlignment: CrossAxisAlignment.start,
//                           //               children: [
//                           //                 Text(
//                           //                   '${battery.name}',
//                           //                   style: TextStyle(fontSize: 17.0),
//                           //                 ),
//                           //                 const SizedBox(height: 6.0),
//                           //                 Text(
//                           //                   '100AH',
//                           //                   style: TextStyle(
//                           //                     fontSize: 15.0,
//                           //                     color: Colors.grey.shade700,
//                           //                   ),
//                           //                 ),
//                           //                 const SizedBox(height: 1.0),
//                           //                 Text(
//                           //                   ' IAB991818111',
//                           //                   style: TextStyle(
//                           //                     fontSize: 14.0,
//                           //                     color: Colors.grey.shade700,
//                           //                   ),
//                           //                 )
//                           //               ],
//                           //             ),
//                           //             Container(
//                           //               height: 100.0,
//                           //               width: 100.0,
//                           //               child: CachedNetworkImage(
//                           //                 imageUrl: battery.imageUrl ?? '',
//                           //                 fit: BoxFit.contain,
//                           //               ),
//                           //             ),
//                           //           ],
//                           //         ),
//                           //       ),
//                           //     ),
//                           //     Positioned(
//                           //       top: 1.0,
//                           //       right: 4.0,
//                           //       child: CircleAvatar(
//                           //         backgroundColor: Colors.green,
//                           //         radius: 15.0,
//                           //         child: Icon(
//                           //           Icons.call_rounded,
//                           //           color: Colors.white,
//                           //         ),
//                           //       ),
//                           //     )
//                           //   ],
//                           // ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
