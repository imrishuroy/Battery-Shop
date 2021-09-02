part of 'app_actions_bloc.dart';

enum ActionStatus { initial, batteryDashBoard, logout }

class AppActionsState extends Equatable {
  final ActionStatus status;

  const AppActionsState({required this.status});

  factory AppActionsState.initial() =>
      AppActionsState(status: ActionStatus.initial);

  @override
  List<Object> get props => [status];

  AppActionsState copyWith({
    ActionStatus? status,
  }) {
    return AppActionsState(
      status: status ?? this.status,
    );
  }
}
