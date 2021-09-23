import '/enums/enums.dart';
import '/models/vehicle_battery.dart';
import '/repositories/battery/battery_repository.dart';
import '/screens/set-priority/bloc/set_priority_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BatteryPriorityTile extends StatefulWidget {
  final VehicleBattery? vehicleBattery;
  final String? vehicleBrandId;
  final FuelType? fuelType;
  final String? vehicleId;
  final String vehicleType;

  const BatteryPriorityTile({
    Key? key,
    required this.vehicleBattery,
    required this.vehicleBrandId,
    required this.fuelType,
    required this.vehicleId,
    required this.vehicleType,
  }) : super(key: key);

  @override
  _BatteryPriorityTileState createState() => _BatteryPriorityTileState();
}

class _BatteryPriorityTileState extends State<BatteryPriorityTile> {
  onSave() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        final batteryRepo = context.read<BatteryRepository>();
        print('THis runs');
        await batteryRepo.editBatteryPriority(
          vehicleBrandId: widget.vehicleBrandId,
          fuelType: widget.fuelType,
          vehicleId: widget.vehicleId,
          type: widget.vehicleBattery?.battery?.type,
          priority: priority,
          vehicleType: widget.vehicleType,
        );
      }
      context.read<SetPriorityBloc>().add(RefreshPriotity());
    } catch (error) {
      print('Error editing priority');
    }
  }

  int priority = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14.0, 20.0, 14.0, 3.0),
      child: Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: [
              Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
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
                        '₹${widget.vehicleBattery?.battery?.mrp}',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 15.0),
                  Container(
                    width: 175,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.vehicleBattery?.battery?.type}',
                          style: TextStyle(
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
                        Text(
                            'Warrenty - ${widget.vehicleBattery?.battery?.warranty}'),
                        // Text(
                        //   'AH1 - 100AH',
                        //   style: TextStyle(
                        //     color: Colors.grey.shade700,
                        //   ),
                        // ),
                        const SizedBox(height: 30.0),
                        // Text('Dealer Price'),
                        Text('( Excluding GST )')
                      ],
                    ),
                  ),
                  Text('${widget.vehicleBattery?.priority}'),

                  Spacer(),

                  SizedBox(
                    width: 70.0,
                    height: 50.0,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      initialValue: '${widget.vehicleBattery?.priority}',
                      //  controller: _priorityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: 'Add Priority'),
                      onSaved: (value) {
                        print('Value');
                        if (value != null) {
                          priority = int.parse(value);
                        }
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: onSave,
                    icon: Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.only(right: 5.0),
                  //   child: InkWell(
                  //     onTap: () {
                  //       // launch('tel://1234567890');
                  //     },
                  //     child: Column(
                  //       children: [
                  //         Icon(
                  //           Icons.call,
                  //           color: Colors.green,
                  //         ),
                  //         const SizedBox(height: 6.0),
                  //         Text('Call'),
                  //         Text('Distributor')
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
              const SizedBox(height: 4.5),
              Divider(
                color: Colors.grey.shade800,
              )
            ],
          ),
        ),
      ),
    );
  }
}
