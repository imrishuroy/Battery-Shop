import 'dart:async';
import '/models/failure.dart';
import '/models/vehicle.dart';
import '/models/vehicle_type.dart';
import '/repository/services/firebase_service.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'vehicles_bloc_event.dart';
part 'vehicles_bloc_state.dart';

class VehiclesBloc extends Bloc<VehiclesBlocEvent, VehiclesBlocState> {
  VehiclesBloc({
    required FirebaseServices firebaseServices,
    required String? vehicleBrandId,
    required FuelType fuelType,
    required String vehicleType,
  })  : _firebaseServices = firebaseServices,
        _vehicleBrandId = vehicleBrandId,
        _fuelType = fuelType,
        _vehilceType = vehicleType,
        super(VehiclesBlocState.initial()) {
    _vehiclesSubscription?.cancel();
    _vehiclesSubscription = Stream<List<Vehicle?>>.fromFuture(
        _firebaseServices.getVehiclesAssociatedWithBrands(
      vehicleBrandId: _vehicleBrandId,
      fuelType: _fuelType,
      vehicleType: _vehilceType,
    )).listen(
      (List<Vehicle?> vehicles) => add(
        LoadVehicles(vehicles: vehicles),
      ),
    );
  }

  final FirebaseServices _firebaseServices;
  StreamSubscription<dynamic>? _vehiclesSubscription;
  final String? _vehicleBrandId;
  final FuelType _fuelType;
  final String _vehilceType;

  @override
  Future<void> close() {
    _vehiclesSubscription?.cancel();

    return super.close();
  }

  @override
  Stream<VehiclesBlocState> mapEventToState(
    VehiclesBlocEvent event,
  ) async* {
    if (event is LoadVehicles) {
      yield* _mapLoadVehiclesToState(event);
    } else if (event is RefreshVehicles) {
      yield* _mapRefreshVehiclesToState();
    }
  }

  Stream<VehiclesBlocState> _mapLoadVehiclesToState(LoadVehicles event) async* {
    yield state.copyWith(
      vehicles: event.vehicles,
      status: VehiclesBlocStatus.succuss,
    );
  }

  Stream<VehiclesBlocState> _mapRefreshVehiclesToState() async* {
    _vehiclesSubscription?.cancel();
    _vehiclesSubscription = Stream<List<Vehicle?>>.fromFuture(
            _firebaseServices.getVehiclesAssociatedWithBrands(
                vehicleBrandId: _vehicleBrandId,
                fuelType: _fuelType,
                vehicleType: _vehilceType))
        .listen(
            (List<Vehicle?> vehicles) => add(LoadVehicles(vehicles: vehicles)));
  }
}
