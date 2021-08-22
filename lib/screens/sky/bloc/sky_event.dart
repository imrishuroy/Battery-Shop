part of 'sky_bloc.dart';

abstract class SkyEvent extends Equatable {
  const SkyEvent();

  @override
  List<Object> get props => [];
}

class LoadSkyBatteries extends SkyEvent {
  final List<Battery?> batteries;

  LoadSkyBatteries({required this.batteries});

  @override
  List<Object> get props => [batteries];

  @override
  bool? get stringify => true;
}

class RefreshSkyBatteries extends SkyEvent {}
