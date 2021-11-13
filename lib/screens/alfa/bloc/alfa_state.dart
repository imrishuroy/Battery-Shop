part of 'alfa_bloc.dart';

enum AlfaStatus { initial, loading, loaded, error }

class AlfaState extends Equatable {
  final List<Battery?> batteries;
  final Failure failure;
  final AlfaStatus status;
  final List<Battery?> remoteBatteries;
  AlfaState({
    required this.batteries,
    required this.failure,
    required this.status,
    required this.remoteBatteries,
  });

  @override
  List<Object> get props => [batteries, failure, status, remoteBatteries];

  AlfaState copyWith({
    List<Battery?>? batteries,
    Failure? failure,
    AlfaStatus? status,
    List<Battery?>? remoteBatteries,
  }) {
    return AlfaState(
      batteries: batteries ?? this.batteries,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      remoteBatteries: remoteBatteries ?? this.remoteBatteries,
    );
  }

  factory AlfaState.initial() => AlfaState(
        batteries: [],
        failure: Failure(),
        status: AlfaStatus.initial,
        remoteBatteries: [],
      );

  @override
  bool get stringify => true;
}
