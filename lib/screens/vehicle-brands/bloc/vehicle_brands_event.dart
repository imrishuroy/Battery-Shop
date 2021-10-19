part of 'vehicle_brands_bloc.dart';

abstract class VehicleBrands extends Equatable {
  const VehicleBrands();

  @override
  List<Object> get props => [];
}

class LoadVehicleBrands extends VehicleBrands {
  final List<VehicleBrand?> vehicleBrands;

  LoadVehicleBrands({required this.vehicleBrands});

  @override
  List<Object> get props => [vehicleBrands];
}

class DeleteVehicleBrand extends VehicleBrands {
  final String vehicleBrandId;

  DeleteVehicleBrand({required this.vehicleBrandId});

  @override
  List<Object> get props => [vehicleBrandId];
}
