part of 'app_actions_bloc.dart';

abstract class AppActionsEvent extends Equatable {
  const AppActionsEvent();

  @override
  List<Object> get props => [];
}

class ChangeActionStatus extends AppActionsEvent {
  final ActionStatus status;

  ChangeActionStatus({required this.status});

  @override
  List<Object> get props => [status];
}
