part of 'vehicle_batteries_bloc.dart';

abstract class VehicleBatteriesEvent extends Equatable {
  const VehicleBatteriesEvent();

  @override
  List<Object> get props => [];
}

class LoadVehicleBatteries extends VehicleBatteriesEvent {
  final List<Battery?> vehicleBatteries;

  LoadVehicleBatteries({required this.vehicleBatteries});

  @override
  List<Object> get props => [vehicleBatteries];

  @override
  bool? get stringify => true;
}
