part of 'set_priority_bloc.dart';

abstract class SetPriorityEvent extends Equatable {
  const SetPriorityEvent();

  @override
  List<Object> get props => [];
}

class LoadPriorityBatteries extends SetPriorityEvent {
  final List<Battery?> batteries;

  LoadPriorityBatteries({
    required this.batteries,
  });
}

class UpdateBatteryPriority extends SetPriorityEvent {
  final int? oldIndex;
  final int? newIndex;
  final String? type1;
  final String? type2;

  UpdateBatteryPriority({
    required this.oldIndex,
    required this.newIndex,
    required this.type2,
    required this.type1,
  });
}
