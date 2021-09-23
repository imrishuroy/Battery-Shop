import 'dart:async';
import '/enums/enums.dart';
import '/models/failure.dart';
import '/models/vehicle_battery.dart';
import '/repositories/battery/battery_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'set_priority_event.dart';
part 'set_priority_state.dart';

class SetPriorityBloc extends Bloc<SetPriorityEvent, SetPriorityState> {
  StreamSubscription? _batterySubscription;
  final BatteryRepository _batteryRepository;
  final String? _vehicleBrandId;
  final String? _vehicleId;
  final FuelType _fuelType;
  final String _vehicleType;

  SetPriorityBloc({
    required BatteryRepository batteryRepository,
    required String? vehicleBrandId,
    required FuelType fuelType,
    required String? vehicleId,
    required String vehicleType,
  })  : _batteryRepository = batteryRepository,
        _vehicleBrandId = vehicleBrandId,
        _vehicleId = vehicleId,
        _fuelType = fuelType,
        _vehicleType = vehicleType,
        super(SetPriorityState.initial()) {
    _batterySubscription?.cancel();
    _batterySubscription = _batteryRepository
        .streamBatteries(
      vehicleBrandId: _vehicleBrandId,
      fuelType: _fuelType,
      vehicleId: _vehicleId,
      vehicleType: _vehicleType,
    )

        // .streamVehiclesBatteries(
        //     vehicleBrandId: _vehicleBrandId,
        //     fuelType: _fuelType,
        //     vehicleId: _vehicleId)
        .listen((snaps) async {
      final batteries = await Future.wait(snaps);
      add(LoadPriorityBatteries(batteries: batteries));
    });
  }

  @override
  Future<void> close() {
    _batterySubscription?.cancel();
    return super.close();
  }

  @override
  Stream<SetPriorityState> mapEventToState(
    SetPriorityEvent event,
  ) async* {
    if (event is LoadPriorityBatteries) {
      yield* _mapLoadPriorityBatteriesToState(event);
    } else if (event is UpdateBatteryPriority) {
      _mapUpdateBatteryPriorityToState(event);
    } else if (event is RefreshPriotity) {
      _mapRefreshBatteryPriorityToState();
    }
  }

  Stream<SetPriorityState> _mapLoadPriorityBatteriesToState(
      LoadPriorityBatteries event) async* {
    yield state.copyWith(
      batteries: event.batteries,
      status: PriortyStatus.succuss,
    );
  }

  Stream<SetPriorityState> _mapUpdateBatteryPriorityToState(
      UpdateBatteryPriority event) async* {
    await _batteryRepository.editBatteryPriority(
      vehicleBrandId: _vehicleBrandId,
      fuelType: _fuelType,
      vehicleId: _vehicleId,
      vehicleType: _vehicleType,
      //   battery: event.newIndex,
      type: event.vehicleBattery.battery?.type,

      priority: event.vehicleBattery.priority,
    );

    // await _batteryRepository.editBatteryPriority(
    //   vehicleBrandId: _vehicleBrandId,
    //   fuelType: _fuelType,
    //   vehicleId: _vehicleId,
    //   //  battery: event.oldIndex,
    //   type: event.type2,
    //   priority: event.oldIndex,
    // );
    // _batterySubscription = _batteryRepository
    //     .streamVehiclesBatteries(
    //         vehicleBrandId: _vehicleBrandId,
    //         fuelType: _fuelType,
    //         vehicleId: _vehicleId)
    //     .listen((snaps) async {
    //   final batteries = await Future.wait(snaps);
    //   add(LoadPriorityBatteries(batteries: batteries));
    // });
  }

  Stream<SetPriorityState> _mapRefreshBatteryPriorityToState() async* {
    _batterySubscription?.cancel();
    _batterySubscription = _batteryRepository
        .streamBatteries(
      vehicleBrandId: _vehicleBrandId,
      fuelType: _fuelType,
      vehicleId: _vehicleId,
      vehicleType: _vehicleType,
    )
        // .streamVehiclesBatteries(
        //     vehicleBrandId: _vehicleBrandId,
        //     fuelType: _fuelType,
        //     vehicleId: _vehicleId)
        .listen((snaps) async {
      final batteries = await Future.wait(snaps);
      add(LoadPriorityBatteries(batteries: batteries));
    });
  }
}
