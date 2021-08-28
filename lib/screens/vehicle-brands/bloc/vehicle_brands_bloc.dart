import 'dart:async';

import 'package:admin_battery/models/brands.dart';
import 'package:admin_battery/models/failure.dart';
import 'package:admin_battery/repositories/firebase_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vehicle_brands_event.dart';
part 'vehicle_brands_state.dart';

class VehicleBrandsBloc extends Bloc<VehicleBrands, VehicleBrandsState> {
  StreamSubscription? _vehicleBrandsSubscription;
  final FirebaseServices _firebaseServices;

  VehicleBrandsBloc({required FirebaseServices firebaseServices})
      : _firebaseServices = firebaseServices,
        super(VehicleBrandsState.initial()) {
    _vehicleBrandsSubscription?.cancel();
    _vehicleBrandsSubscription = _firebaseServices
        .carBrandsStream()
        .listen((brands) => add(LoadVehicleBrands(vehicleBrands: brands)));
  }

  @override
  Stream<VehicleBrandsState> mapEventToState(
    VehicleBrands event,
  ) async* {
    if (event is LoadVehicleBrands) {
      yield* _mapLoadVehicleBrandsToState(event);
    }
  }

  Stream<VehicleBrandsState> _mapLoadVehicleBrandsToState(
      LoadVehicleBrands event) async* {
    yield state.copyWith(
      brands: event.vehicleBrands,
      status: VehicleBrandsStatus.succuss,
    );
  }
}
