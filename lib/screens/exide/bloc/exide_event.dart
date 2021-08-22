part of 'exide_bloc.dart';

abstract class ExideEvent extends Equatable {
  const ExideEvent();

  @override
  List<Object> get props => [];
}

class LoadExideBatteries extends ExideEvent {
  final List<Battery?> batteries;

  LoadExideBatteries({required this.batteries});

  @override
  List<Object> get props => [batteries];

  @override
  bool? get stringify => true;
}

class RefreshExideBatteries extends ExideEvent {}
