part of 'amaron_bloc.dart';

enum AmaronStatus { initial, loading, loaded, error }

class AmaronState extends Equatable {
  final List<Battery?> batteries;
  final Failure failure;
  final AmaronStatus status;
  final List<Battery?> remoteBatteries;

  AmaronState({
    required this.batteries,
    required this.failure,
    required this.status,
    required this.remoteBatteries,
  });

  factory AmaronState.initial() => AmaronState(
        batteries: [],
        failure: Failure(),
        status: AmaronStatus.initial,
        remoteBatteries: [],
      );

  AmaronState copyWith({
    List<Battery?>? batteries,
    Failure? failure,
    AmaronStatus? status,
    final List<Battery?>? remoteBatteries,
  }) {
    return AmaronState(
      batteries: batteries ?? this.batteries,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      remoteBatteries: remoteBatteries ?? this.remoteBatteries,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [batteries, failure, status, remoteBatteries];
}
