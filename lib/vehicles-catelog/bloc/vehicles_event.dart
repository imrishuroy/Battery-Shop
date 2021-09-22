part of 'vehicles_bloc.dart';

abstract class VehiclesEvent extends Equatable {
  const VehiclesEvent();

  @override
  List<Object> get props => [];
}

class LoadVehicles extends VehiclesEvent {
  final List<Vehicle?> vehicles;

  LoadVehicles({required this.vehicles});

  @override
  List<Object> get props => [vehicles];
  @override
  bool? get stringify => true;
}

class RefreshVehiclesList extends VehiclesEvent {
  @override
  bool? get stringify => true;
}
