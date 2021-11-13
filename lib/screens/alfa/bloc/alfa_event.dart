part of 'alfa_bloc.dart';

abstract class AlfaEvent extends Equatable {
  const AlfaEvent();

  @override
  List<Object> get props => [];
}

class LoadAlfaBatteries extends AlfaEvent {
  final List<Battery?> batteries;

  LoadAlfaBatteries({required this.batteries});

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [batteries];
}

class RefreshAlfaBatteries extends AlfaEvent {
  @override
  bool? get stringify => true;
}

class LoadRemoteBatteries extends AlfaEvent {
  final List<Battery?> remoteBatteries;

  LoadRemoteBatteries({required this.remoteBatteries});
  @override
  List<Object> get props => [remoteBatteries];
  @override
  bool? get stringify => true;
}
