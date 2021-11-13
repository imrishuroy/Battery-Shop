part of 'luminous_bloc.dart';

abstract class LuminousEvent extends Equatable {
  const LuminousEvent();

  @override
  List<Object> get props => [];
}

class LoadLuminousBatteries extends LuminousEvent {
  // final List<Battery?> batteries;

  final List<Battery?> batteries;

  LoadLuminousBatteries({required this.batteries});

  @override
  List<Object> get props => [batteries];

  @override
  bool? get stringify => true;
}

class RefreshLuminousBatteries extends LuminousEvent {}
