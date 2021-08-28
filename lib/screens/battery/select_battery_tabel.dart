import 'package:admin_battery/enums/enums.dart';
import 'package:admin_battery/models/battery.dart';
import 'package:admin_battery/repositories/firebase_services.dart';
import 'package:admin_battery/widgets/table_entry_text.dart';
import 'package:admin_battery/widgets/table_heading_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SelectBatteryTable extends StatefulWidget {
  final List<Battery?> batteries;

  final String? vehicleBrandId;
  final FuelType fuelType;
  final String? vehicleId;

  SelectBatteryTable(
      {Key? key,
      required this.batteries,
      required this.vehicleBrandId,
      required this.fuelType,
      required this.vehicleId})
      : super(key: key);

  @override
  _SelectBatteryTableState createState() => _SelectBatteryTableState();
}

class _SelectBatteryTableState extends State<SelectBatteryTable> {
  _submit(BuildContext context) async {
    final _firebaseService = context.read<FirebaseServices>();
    await _firebaseService.addBatteryToVehicle(
      vehicleBrandId: widget.vehicleBrandId,
      fuelType: widget.fuelType,
      vehicleId: widget.vehicleId,
      battery: _battery,
      batteryBrand: 'amaron',
    );
  }

  Battery? _battery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _submit(context),
        child: Icon(Icons.add),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    defaultColumnWidth: FixedColumnWidth(120.0),
                    border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2),
                    children: [
                      TableRow(
                        children: [
                          TableHeadingText(label: 'S.N0.'),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: TableHeadingText(
                              label: 'TYPE',
                              textAlign: TextAlign.start,
                            ),
                          ),
                          TableHeadingText(label: 'AH RATING'),
                          TableHeadingText(label: 'WARRANTY'),
                          TableHeadingText(label: 'DP PRICE'),
                          TableHeadingText(label: 'MRP'),
                          TableHeadingText(label: 'SCRAP'),
                          TableHeadingText(label: 'Select')
                        ],
                      ),
                      for (int i = 0; i < widget.batteries.length; i++)
                        //   for (var amaronBatteries[i] in amaronBatteries)

                        TableRow(
                          children: [
                            TableEntryText(value: '${i + 1}'),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: TableEntryText(
                                value: widget.batteries[i]?.type,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            TableEntryText(
                                value: '${widget.batteries[i]?.ratting}'),
                            TableEntryText(
                                value: '${widget.batteries[i]?.warranty}'),
                            TableEntryText(
                                value: '${widget.batteries[i]?.price}'),
                            TableEntryText(
                                value: '${widget.batteries[i]?.mrp}'),
                            TableEntryText(
                                value: '${widget.batteries[i]?.scrap}'),
                            // Checkbox(value: false, onChanged: (value) {})
                            SelectOneBattery(
                              onPressed: () {
                                setState(() {
                                  _battery = widget.batteries[i];
                                });
                              },
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectOneBattery extends StatefulWidget {
  final Function onPressed;

  const SelectOneBattery({Key? key, required this.onPressed}) : super(key: key);

  @override
  _SelectOneBatteryState createState() => _SelectOneBatteryState();
}

class _SelectOneBatteryState extends State<SelectOneBattery> {
  bool _isSelected = false;

  void _onSelect(bool? value) {
    widget.onPressed();
    setState(() {
      if (value != null) {
        _isSelected = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(value: _isSelected, onChanged: _onSelect);
  }
}
