part of 'vehicle_batteries_bloc.dart';

abstract class VehicleBatteriesEvent extends Equatable {
  const VehicleBatteriesEvent();

  @override
  List<Object> get props => [];
}

class LoadVehicleBatteries extends VehicleBatteriesEvent {
  final List<Battery?> vehicleBatteries;

  const LoadVehicleBatteries({required this.vehicleBatteries});

  @override
  List<Object> get props => [vehicleBatteries];

  @override
  bool? get stringify => true;
}

class UpdateVehicleBatteries extends VehicleBatteriesEvent {
  final List<Battery?> updatedBatteries;

  const UpdateVehicleBatteries({required this.updatedBatteries});

  @override
  List<Object> get props => [updatedBatteries];

  @override
  bool? get stringify => true;
}

class DeleteAVehicleBattery extends VehicleBatteriesEvent {
  final Battery battery;

  const DeleteAVehicleBattery({required this.battery});
  @override
  List<Object> get props => [battery];

  @override
  bool? get stringify => true;
}

class AddAVehicleBattery extends VehicleBatteriesEvent {
  final Battery battery;

  const AddAVehicleBattery({required this.battery});
  @override
  List<Object> get props => [battery];

  @override
  bool? get stringify => true;
}
