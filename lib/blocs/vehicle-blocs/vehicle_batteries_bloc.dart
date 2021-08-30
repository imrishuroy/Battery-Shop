import 'dart:async';
import 'package:admin_battery/enums/enums.dart';
import 'package:admin_battery/models/battery.dart';
import 'package:admin_battery/models/failure.dart';
import 'package:admin_battery/repositories/battery/battery_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vehicle_batteries_event.dart';
part 'vehicle_batteries_state.dart';

class VehicleBatteriesBloc
    extends Bloc<VehicleBatteriesEvent, VehicleBatteriesState> {
  StreamSubscription? _batterySubscription;

  final BatteryRepository _batteryRepository;
  final String? _vehicleBrandId;
  final FuelType _fuelType;
  final String? _vehicleId;

  VehicleBatteriesBloc({
    required BatteryRepository batteryRepository,
    required String? vehicleBrandId,
    required FuelType fuelType,
    required String? vehicleId,
  })  : _batteryRepository = batteryRepository,
        _fuelType = fuelType,
        _vehicleBrandId = vehicleBrandId,
        _vehicleId = vehicleId,
        super(VehicleBatteriesState.initial()) {
    _batterySubscription?.cancel();
    _batterySubscription = _batteryRepository
        .streamVehiclesBatteries(
      vehicleBrandId: _vehicleBrandId,
      fuelType: _fuelType,
      vehicleId: _vehicleId,
    )
        .listen((batteries) async {
      final vehicleBatteries = await Future.wait(batteries);
      print('Vehicles Battery $vehicleBatteries');
      return add(LoadVehicleBatteries(vehicleBatteries: vehicleBatteries));
    });

    // _batterySubscription = _batteryRepository

    //     .streamRemoteBatteries(
    //         vehicleBrandId: _vehicleBrandId,
    //         fuelType: _fuelType,
    //         vehicleId: _vehicleId)
    //     .listen((batteries) =>
    //         add(LoadVehicleBatteries(vehicleBatteries: batteries)));
  }

  @override
  Future<void> close() {
    _batterySubscription?.cancel();
    return super.close();
  }

  @override
  Stream<VehicleBatteriesState> mapEventToState(
    VehicleBatteriesEvent event,
  ) async* {
    if (event is LoadVehicleBatteries) {
      yield* _mapLoadVehicleBatteriesToState(event);
    }
    //else if (event is UpdateVehicleBatteries) {
    //yield* _mapUpdateVehicleBatteriesToState(event);
    //}
    else if (event is DeleteAVehicleBattery) {
      yield* _mapDeleteABatteryToState(event);
    } else if (event is AddAVehicleBattery) {
      yield* _mapAddAVehicleBatteryToState(event);
    }
  }

  Stream<VehicleBatteriesState> _mapLoadVehicleBatteriesToState(
      LoadVehicleBatteries event) async* {
    yield state.copyWith(
      vehicleBatteries: event.vehicleBatteries,
      status: VehicleBatteriesStatus.succuss,
    );
  }

  // Stream<VehicleBatteriesState> _mapUpdateVehicleBatteriesToState(
  //     UpdateVehicleBatteries event) async* {
  //   // yield VehicleBatteriesState.loaded(batteries: event.updatedBatteries);
  //   yield state.copyWith(
  //     vehicleBatteries: event.updatedBatteries,
  //     status: VehicleBatteriesStatus.succuss,
  //   );
  // }

  Stream<VehicleBatteriesState> _mapAddAVehicleBatteryToState(
      AddAVehicleBattery event) async* {
    _batteryRepository.addBatteryToVehicle(
      vehicleBrandId: _vehicleBrandId,
      fuelType: _fuelType,
      vehicleId: _vehicleId,
      batteryType: event.battery.type,
      batteryBrand: 'amaron',
    );
  }

  Stream<VehicleBatteriesState> _mapDeleteABatteryToState(
      DeleteAVehicleBattery event) async* {
    _batteryRepository.removeBatteryFromVehicle(
      vehicleBrandId: _vehicleBrandId,
      fuelType: _fuelType,
      vehicleId: _vehicleId,
      batteryType: event.battery.type,
    );

    // if (state.vehicleBatteries.contains(event.battery)) {
    //   print('Vehicle Battery Contains ${event.battery}');
    //   final batteries = state.vehicleBatteries;
    //   final result = batteries.remove(event.battery);
    //   print('Batteris $batteries');

    //   if (result) {
    //     //state.vehicleBatteries.remove(event.battery);
    //     // yield state.copyWith(
    //     //   vehicleBatteries: batteries,
    //     //   status: VehicleBatteriesStatus.succuss,
    //     // );
    //     yield VehicleBatteriesState.loaded(batteries: batteries);
    //   }
    // } else {
    //   print('Vehicle Battery Does not contains the ${event.battery}');
    //   yield state.copyWith(
    //     vehicleBatteries: state.vehicleBatteries,
    //     status: VehicleBatteriesStatus.succuss,
    //   );
    // }
  }
}
