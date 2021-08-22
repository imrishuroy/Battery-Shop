part of 'amaron_bloc.dart';

enum AmaronStatus { initial, loading, loaded, error }

class AmaronState extends Equatable {
  final List<Battery?> batteries;
  final Failure failure;
  final AmaronStatus status;

  AmaronState({
    required this.batteries,
    required this.failure,
    required this.status,
  });

  factory AmaronState.initial() => AmaronState(
      batteries: [], failure: Failure(), status: AmaronStatus.initial);

  AmaronState copyWith({
    List<Battery?>? batteries,
    Failure? failure,
    AmaronStatus? status,
  }) {
    return AmaronState(
      batteries: batteries ?? this.batteries,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [batteries, failure, status];
}
