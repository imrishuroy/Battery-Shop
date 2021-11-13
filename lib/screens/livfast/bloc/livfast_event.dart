part of 'livfast_bloc.dart';

abstract class LivFastEvent extends Equatable {
  const LivFastEvent();

  @override
  List<Object> get props => [];
}

class LoadLivFastBatteries extends LivFastEvent {
  final List<Battery?> batteries;

  LoadLivFastBatteries({required this.batteries});

  @override
  List<Object> get props => [batteries];

  @override
  bool? get stringify => true;
}

class RefreshLivFastBatteries extends LivFastEvent {}
