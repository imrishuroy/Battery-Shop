part of 'vehicles_bloc_bloc.dart';

enum VehiclesBlocStatus {
  initial,
  loading,
  succuss,
  error,
}

class VehiclesBlocState extends Equatable {
  final List<Vehicle?> vehicles;
  final Failure failure;
  final VehiclesBlocStatus status;

  const VehiclesBlocState({
    required this.vehicles,
    required this.failure,
    required this.status,
  });

  @override
  List<Object> get props => [vehicles, failure, status];

  factory VehiclesBlocState.initial() => VehiclesBlocState(
      vehicles: [], failure: Failure(), status: VehiclesBlocStatus.initial);

  VehiclesBlocState copyWith({
    List<Vehicle?>? vehicles,
    Failure? failure,
    VehiclesBlocStatus? status,
  }) {
    return VehiclesBlocState(
      vehicles: vehicles ?? this.vehicles,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
