part of 'vehilce_brands_bloc.dart';

enum VehicleBrandsStatus { initial, loading, succuss, errror }

class VehilceBrandsState extends Equatable {
  final List<VehicleBrand?> vehicleBrands;
  final Failure failure;
  final VehicleBrandsStatus status;

  const VehilceBrandsState({
    required this.vehicleBrands,
    required this.failure,
    required this.status,
  });

  @override
  List<Object?> get props => [vehicleBrands, failure, status];

  factory VehilceBrandsState.initial() => const VehilceBrandsState(
      vehicleBrands: [],
      failure: Failure(),
      status: VehicleBrandsStatus.initial);

  VehilceBrandsState copyWith({
    List<VehicleBrand?>? vehicleBrands,
    Failure? failure,
    VehicleBrandsStatus? status,
  }) {
    return VehilceBrandsState(
      vehicleBrands: vehicleBrands ?? this.vehicleBrands,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
