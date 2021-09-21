part of 'vehicles_bloc_bloc.dart';

enum VehiclesBlocStatus {
  initial,
  loading,
  succuss,
  error,
}

class VehiclesBlocState extends Equatable {
  const VehiclesBlocState({
    required this.vehicles,
    required this.failure,
    required this.status,
  });

  factory VehiclesBlocState.initial() => const VehiclesBlocState(
        vehicles: <Vehicle?>[],
        failure: Failure(),
        status: VehiclesBlocStatus.initial,
      );

  final List<Vehicle?> vehicles;
  final Failure failure;
  final VehiclesBlocStatus status;

  @override
  List<Object> get props => <Object>[vehicles, failure, status];

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
