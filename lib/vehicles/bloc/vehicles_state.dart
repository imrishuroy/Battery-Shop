part of 'vehicles_bloc.dart';

enum VehicleStatus { initial, loading, succuss, error }

class VehiclesState extends Equatable {
  final List<Vehicle?> vehicles;
  final Failure failure;
  final VehicleStatus status;

  const VehiclesState({
    required this.vehicles,
    required this.failure,
    required this.status,
  });

  @override
  List<Object?> get props => [vehicles, failure, status];

  factory VehiclesState.initial() => VehiclesState(
      vehicles: [], failure: Failure(), status: VehicleStatus.initial);

  VehiclesState copyWith({
    List<Vehicle?>? vehicles,
    Failure? failure,
    VehicleStatus? status,
  }) {
    return VehiclesState(
      vehicles: vehicles ?? this.vehicles,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
