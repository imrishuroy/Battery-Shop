part of 'vehicle_batteries_bloc.dart';

enum VehicleBatteriesStatus { initial, loading, succuss, error }

class VehicleBatteriesState extends Equatable {
  const VehicleBatteriesState({
    required this.vehicleBatteries,
    required this.failure,
    required this.status,
  });

  final List<Battery?> vehicleBatteries;
  final Failure failure;
  final VehicleBatteriesStatus status;

  @override
  List<Object> get props => [vehicleBatteries, failure, status];

  factory VehicleBatteriesState.initial() => const VehicleBatteriesState(
      vehicleBatteries: [],
      failure: Failure(),
      status: VehicleBatteriesStatus.initial);

  factory VehicleBatteriesState.loaded({required List<Battery?> batteries}) =>
      VehicleBatteriesState(
        vehicleBatteries: batteries,
        failure: const Failure(),
        status: VehicleBatteriesStatus.succuss,
      );

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
