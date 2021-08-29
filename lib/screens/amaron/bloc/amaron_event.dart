part of 'amaron_bloc.dart';

abstract class AmaronEvent extends Equatable {
  const AmaronEvent();

  @override
  List<Object> get props => [];
}

class LoadAmaronBatteries extends AmaronEvent {
  final List<Battery?> batteries;

  LoadAmaronBatteries({required this.batteries});

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [batteries];
}

class RefreshAmaronBatteries extends AmaronEvent {
  @override
  bool? get stringify => true;
}

class LoadRemoteBatteries extends AmaronEvent {
  final List<Battery?> remoteBatteries;

  LoadRemoteBatteries({required this.remoteBatteries});
  @override
  List<Object> get props => [remoteBatteries];
  @override
  bool? get stringify => true;
}
