part of 'vehicle_batteries_bloc.dart';

enum VehicleBatteriesStatus { initial, loading, succuss, error }

class VehicleBatteriesState extends Equatable {
  final List<Battery?> vehicleBatteries;
  final Failure failure;
  final VehicleBatteriesStatus status;

  VehicleBatteriesState({
    required this.vehicleBatteries,
    required this.failure,
    required this.status,
  });

  @override
  List<Object> get props => [vehicleBatteries, failure, status];

  factory VehicleBatteriesState.initial() => VehicleBatteriesState(
      vehicleBatteries: [],
      failure: Failure(),
      status: VehicleBatteriesStatus.initial);

  VehicleBatteriesState copyWith({
    List<Battery?>? vehicleBatteries,
    Failure? failure,
    VehicleBatteriesStatus? status,
  }) {
    return VehicleBatteriesState(
      vehicleBatteries: vehicleBatteries ?? this.vehicleBatteries,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
