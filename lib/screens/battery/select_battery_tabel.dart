import '/widgets/loading_indicator.dart';

import '/blocs/vehicle-blocs/vehicle_batteries_bloc.dart';
import '/enums/enums.dart';
import '/models/battery.dart';

import '/widgets/table_entry_text.dart';
import '/widgets/table_heading_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SelectBatteryTable extends StatelessWidget {
  final List<Battery?> batteries;
  final String? vehicleBrandId;
  final FuelType fuelType;
  final String? vehicleId;

  SelectBatteryTable({
    Key? key,
    required this.batteries,
    required this.vehicleBrandId,
    required this.fuelType,
    required this.vehicleId,
  }) : super(key: key);

  void _addOrDeleteBattery(
    BuildContext context, {
    required Battery? currentBattery,
    required List<Battery?> batteries,
  }) async {
    try {
      if (currentBattery != null) {
        if (batteries.contains(currentBattery)) {
          print('Contains');

          context
              .read<VehicleBatteriesBloc>()
              .add(DeleteAVehicleBattery(battery: currentBattery));
        } else {
          print('Dones not contains');

          context
              .read<VehicleBatteriesBloc>()
              .add(AddAVehicleBattery(battery: currentBattery));
        }
      }
    } catch (error) {
      print('Error addding deleting battery ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<VehicleBatteriesBloc, VehicleBatteriesState>(
        listener: (context, state) {
          print('Vehicel Bloc Status ${state.status}');
        },
        builder: (context, state) {
          switch (state.status) {
            case VehicleBatteriesStatus.error:
              return Center(
                child: Text('Something went wrong'),
              );

            case VehicleBatteriesStatus.succuss:
              return Center(
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
                              width: 2,
                            ),
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
                              for (int i = 0; i < batteries.length; i++)
                                TableRow(
                                  children: [
                                    TableEntryText(value: '${i + 1}'),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: TableEntryText(
                                        value: batteries[i]?.type,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    TableEntryText(
                                        value: '${batteries[i]?.ratting}'),
                                    TableEntryText(
                                        value: '${batteries[i]?.warranty}'),
                                    TableEntryText(
                                        value: '${batteries[i]?.price}'),
                                    TableEntryText(
                                        value: '${batteries[i]?.mrp}'),
                                    TableEntryText(
                                        value: '${batteries[i]?.scrap}'),
                                    SelectOneBattery(
                                      onCheckboxChanged: (_) =>
                                          _addOrDeleteBattery(context,
                                              currentBattery: batteries[i],
                                              batteries:
                                                  state.vehicleBatteries),
                                      isSelected: state.vehicleBatteries
                                          .contains(batteries[i]),
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
              );

            default:
              return LoadingIndicator();
          }
        },
      ),
    );
  }
}

class SelectOneBattery extends StatelessWidget {
  //final Function onPressed;
  final ValueChanged<bool?>? onCheckboxChanged;
  final bool isSelected;

  const SelectOneBattery(
      {Key? key, this.onCheckboxChanged, required this.isSelected})
      : super(key: key);

  // bool _isSelected = false;

  // void _onSelect(bool? value) {
  //   onPressed();
  //   setState(() {
  //     if (value != null) {
  //       _isSelected = value;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Checkbox(value: isSelected, onChanged: onCheckboxChanged);
  }
}
