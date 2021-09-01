part of 'vehilce_brands_bloc.dart';

abstract class VehilceBrandsEvent extends Equatable {
  const VehilceBrandsEvent();

  @override
  List<Object> get props => [];
}

class LoadVehicleBrands extends VehilceBrandsEvent {
  final List<VehicleBrand?> vehicleBrands;

  LoadVehicleBrands({required this.vehicleBrands});

  @override
  List<Object> get props => [vehicleBrands];
}
