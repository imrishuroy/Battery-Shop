import 'dart:async';

import '/models/failure.dart';
import '/models/vehilce_brands.dart';
import '/repository/services/firebase_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vehilce_brands_event.dart';
part 'vehilce_brands_state.dart';

class VehilceBrandsBloc extends Bloc<VehilceBrandsEvent, VehilceBrandsState> {
  final FirebaseServices _firebaseService;
  StreamSubscription? _brandsSubscription;

  VehilceBrandsBloc({required FirebaseServices firebaseService})
      : _firebaseService = firebaseService,
        super(VehilceBrandsState.initial()) {
    _brandsSubscription?.cancel();
    _brandsSubscription = Stream.fromFuture(_firebaseService.getVehicleBrands())
        .listen((brands) => add(LoadVehicleBrands(vehicleBrands: brands)));
  }

  @override
  Stream<VehilceBrandsState> mapEventToState(
    VehilceBrandsEvent event,
  ) async* {
    if (event is LoadVehicleBrands) {
      yield* _mapLoadVehicleBrandsToState(event);
    }
  }

  Stream<VehilceBrandsState> _mapLoadVehicleBrandsToState(
      LoadVehicleBrands event) async* {
    yield state.copyWith(
      vehicleBrands: event.vehicleBrands,
      status: VehicleBrandsStatus.succuss,
    );
  }
}
