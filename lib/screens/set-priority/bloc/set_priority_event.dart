part of 'set_priority_bloc.dart';

abstract class SetPriorityEvent extends Equatable {
  const SetPriorityEvent();

  @override
  List<Object> get props => [];
}

class LoadPriorityBatteries extends SetPriorityEvent {
  final List<VehicleBattery?> batteries;

  LoadPriorityBatteries({
    required this.batteries,
  });
}

class UpdateBatteryPriority extends SetPriorityEvent {
  // final int? oldIndex;
  // final int? newIndex;
  // final String? type1;
  // final String? type2;

  final VehicleBattery vehicleBattery;

  UpdateBatteryPriority({
    // required this.oldIndex,
    // required this.newIndex,
    // required this.type2,
    // required this.type1,
    required this.vehicleBattery,
  });
}

class RefreshPriotity extends SetPriorityEvent {}
