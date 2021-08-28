part of 'vehicle_brands_bloc.dart';

enum VehicleBrandsStatus { initial, loading, succuss, error }

class VehicleBrandsState extends Equatable {
  final List<VehicleBrand?> brands;
  final VehicleBrandsStatus status;
  final Failure failure;

  const VehicleBrandsState({
    required this.brands,
    required this.status,
    required this.failure,
  });

  factory VehicleBrandsState.initial() => VehicleBrandsState(
      brands: [], status: VehicleBrandsStatus.initial, failure: Failure());

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [brands, status, failure];

  VehicleBrandsState copyWith({
    List<VehicleBrand?>? brands,
    VehicleBrandsStatus? status,
    Failure? failure,
  }) {
    return VehicleBrandsState(
      brands: brands ?? this.brands,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
