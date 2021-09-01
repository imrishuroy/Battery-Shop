import 'dart:async';

import 'package:battery_shop/models/failure.dart';
import 'package:battery_shop/models/vehicle.dart';
import 'package:battery_shop/models/vehicle_type.dart';
import 'package:battery_shop/repository/services/firebase_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vehicles_bloc_event.dart';
part 'vehicles_bloc_state.dart';

class VehiclesBlocBloc extends Bloc<VehiclesBlocEvent, VehiclesBlocState> {
  final FirebaseServices _firebaseServices;
  StreamSubscription? _vehiclesSubscription;
  final String? _vehicleBrandId;
  final FuelType _fuelType;

  VehiclesBlocBloc({
    required FirebaseServices firebaseServices,
    required String? vehicleBrandId,
    required FuelType fuelType,
  })  : _firebaseServices = firebaseServices,
        _vehicleBrandId = vehicleBrandId,
        _fuelType = fuelType,
        super(VehiclesBlocState.initial()) {
    _vehiclesSubscription?.cancel();
    _vehiclesSubscription = Stream.fromFuture(
            _firebaseServices.getVehiclesAssociatedWithBrands(
                vehicleBrandId: _vehicleBrandId, fuelType: _fuelType))
        .listen((vehicles) => add(LoadVehicles(vehicles: vehicles)));
  }

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
    _vehiclesSubscription = Stream.fromFuture(
            _firebaseServices.getVehiclesAssociatedWithBrands(
                vehicleBrandId: _vehicleBrandId, fuelType: _fuelType))
        .listen((vehicles) => add(LoadVehicles(vehicles: vehicles)));
  }
}
