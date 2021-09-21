part of 'vehicles_bloc_bloc.dart';

abstract class VehiclesBlocEvent extends Equatable {
  const VehiclesBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadVehicles extends VehiclesBlocEvent {
  final List<Vehicle?> vehicles;

  const LoadVehicles({required this.vehicles});

  @override
  List<Object> get props => [vehicles];

  @override
  bool? get stringify => true;
}

class RefreshVehicles extends VehiclesBlocEvent {}
