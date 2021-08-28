import 'package:admin_battery/enums/enums.dart';
import 'package:admin_battery/screens/amaron/bloc/amaron_bloc.dart';
import 'package:admin_battery/screens/battery/select_battery_tabel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBatteryToVehicle extends StatefulWidget {
  final String? vehicleBrandId;
  final FuelType fuelType;
  final String? vehicleId;

  const AddBatteryToVehicle(
      {Key? key,
      required this.vehicleBrandId,
      required this.fuelType,
      required this.vehicleId})
      : super(key: key);

  @override
  _AddBatteryToVehicleState createState() => _AddBatteryToVehicleState();
}

class _AddBatteryToVehicleState extends State<AddBatteryToVehicle> {
  String dropdownValue = 'Amaron';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Battery'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          children: [
            Card(
              child: Center(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['Amaron', 'Exide', 'Sky']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
                child: BlocConsumer<AmaronBloc, AmaronState>(
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.status) {
                  case AmaronStatus.error:
                    return Center(
                      child: Text('Something went wrong'),
                    );
                  case AmaronStatus.loaded:
                    return SelectBatteryTable(
                      batteries: state.batteries,
                      vehicleBrandId: widget.vehicleBrandId,
                      vehicleId: widget.vehicleId,
                      fuelType: widget.fuelType,
                    );

                  default:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
