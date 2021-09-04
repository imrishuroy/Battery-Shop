import 'package:admin_battery/enums/enums.dart';
import 'package:admin_battery/models/battery.dart';
import 'package:admin_battery/repositories/battery/battery_repository.dart';
import 'package:admin_battery/screens/set-priority/bloc/set_priority_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriorityTile extends StatefulWidget {
  final Battery? battery;
  final String? vehicleBrandId;
  final FuelType? fuelType;
  final String? vehicleId;

  const PriorityTile({
    Key? key,
    this.battery,
    this.vehicleBrandId,
    required this.fuelType,
    this.vehicleId,
  }) : super(key: key);

  @override
  _PriorityTileState createState() => _PriorityTileState();
}

class _PriorityTileState extends State<PriorityTile> {
  final _formKey = GlobalKey<FormState>();
  final _priorityController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getPriority();
  }

  getPriority() async {
    final batteryRepo = context.read<BatteryRepository>();
    setState(() {
      _isLoading = true;
    });
    final value = await batteryRepo.getBatteryPriority(
      vehicleBrandId: widget.vehicleBrandId,
      fuelType: widget.fuelType,
      vehicleId: widget.vehicleId,
      type: widget.battery?.type,
    );
    _priorityController.text = value.toString();
    setState(() {
      _isLoading = false;
    });
  }

  onSave() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      final batteryRepo = context.read<BatteryRepository>();
      await batteryRepo.editBatteryPriority(
        vehicleBrandId: widget.vehicleBrandId,
        fuelType: widget.fuelType,
        vehicleId: widget.vehicleId,
        type: widget.battery?.type,
        priority: int.tryParse(_priorityController.text),
      );
      context.read<SetPriorityBloc>().add(RefreshPriotity());
    }
  }

  @override
  void dispose() {
    _priorityController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14.0, 20.0, 14.0, 3.0),
      child: Form(
        key: _formKey,
        child: Container(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
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
                              '₹${widget.battery?.mrp}',
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
                                '${widget.battery?.type}',
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
                              Text('Warrenty - ${widget.battery?.warranty}'),
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
                        Spacer(),

                        SizedBox(
                          width: 70.0,
                          height: 50.0,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: _priorityController,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(hintText: 'Add Priority'),
                            onSaved: (value) {
                              print('Value');
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

                        // SizedBox(
                        //     height: 20.0,
                        //     width: 70.0,
                        //     child:
                        //         ElevatedButton(onPressed: () {}, child: Text('Done')))
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
