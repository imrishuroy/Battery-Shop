import '/models/battery.dart';
import '/models/vehicle_type.dart';
import '/repository/services/firebase_service.dart';
import '/screens/battery/bloc/vehicle_batteries_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';

const String batteryUrl =
    'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSS0CU16huyavQJ6_-qgHqE17yaESF6nkvIEKqNvE_Fva7TSjGoqqA9r9J_48puXVF43sjiWyTRhQ&usqp=CAc';

class BatteryRequiredArgs {
  final String? vehicleBrandId;
  final FuelType fuelType;
  final String? vehicleId;
  final String vehicleType;

  const BatteryRequiredArgs({
    required this.vehicleBrandId,
    required this.fuelType,
    required this.vehicleId,
    required this.vehicleType,
  });
}

class BatteryRequiredScreen extends StatelessWidget {
  static const routeName = 'battery-required';

  // final String? vehicleBrandId;
  // final FuelType fuelType;
  // final String? vehicleId;

  const BatteryRequiredScreen({
    Key? key,
    // this.vehicleBrandId,
    // required this.fuelType,
    // required this.vehicleId,
  }) : super(key: key);

  static Route route({required BatteryRequiredArgs? args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider(
        create: (context) => VehicleBatteriesBloc(
          batteryRepository: context.read<FirebaseServices>(),
          vehicleBrandId: args?.vehicleBrandId,
          fuelType: args!.fuelType,
          vehicleId: args.vehicleId,
          vehicleType: args.vehicleType,
        ),
        child: const BatteryRequiredScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Battery Required'),
      ),
      body: Column(
        children: [
          Expanded(
              child: BlocConsumer<VehicleBatteriesBloc, VehicleBatteriesState>(
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.status) {
                case VehicleBatteriesStatus.error:
                  return const Center(
                    child: Text('Someting went wrong :('),
                  );

                case VehicleBatteriesStatus.succuss:
                  final batteries = state.vehicleBatteries;
                  return AnimationLimiter(
                    child: ListView.builder(
                      itemCount: batteries.length,
                      itemBuilder: (context, index) {
                        final battery = batteries[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: BatteryTile(battery: battery),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                default:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          )),
        ],
      ),
    );
  }
}

class BatteryTile extends StatelessWidget {
  const BatteryTile({
    Key? key,
    required this.battery,
  }) : super(key: key);

  final Battery? battery;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14.0, 20.0, 14.0, 3.0),
      child: SizedBox(
        child: Column(
          children: [
            Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 80.0,
                      width: 80.0,
                      child: Image.asset('assets/battery.png'),
                      // child: DisplayImage(
                      //   imageUrl: batteryUrl,
                      // ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      // '₹9999',
                      '₹${battery?.mrp}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 15.0),
                SizedBox(
                  width: 175,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${battery?.type}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2.0),
                      // Text(
                      //   // 'Model TT1001',
                      //   '${battery?.type}',
                      //   style: TextStyle(
                      //     color: Colors.grey.shade700,
                      //   ),
                      // ),
                      Text('Warrenty - ${battery?.warranty}'),
                      // Text(
                      //   'AH1 - 100AH',
                      //   style: TextStyle(
                      //     color: Colors.grey.shade700,
                      //   ),
                      // ),
                      const SizedBox(height: 30.0),
                      // Text('Dealer Price'),
                      const Text('( Excluding GST )')
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: InkWell(
                    onTap: () {
                      launch('tel://1234567890');
                    },
                    child: Column(
                      children: const <Widget>[
                        Icon(
                          Icons.call,
                          color: Colors.green,
                        ),
                        SizedBox(height: 6.0),
                        Text('Call'),
                        Text('Distributor')
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 4.5),
            Divider(
              color: Colors.grey.shade800,
            )
          ],
        ),
      ),
    );
  }
}
