part of 'exide_bloc.dart';

enum ExideStatus { initial, loading, loaded, error }

class ExideState extends Equatable {
  final List<Battery?> batteries;
  final ExideStatus status;
  final Failure failure;

  ExideState({
    required this.batteries,
    required this.status,
    required this.failure,
  });

  @override
  List<Object?> get props => [batteries, status, failure];

  factory ExideState.initial() => ExideState(
      batteries: [], status: ExideStatus.initial, failure: Failure());

  ExideState copyWith({
    List<Battery?>? batteries,
    ExideStatus? status,
    Failure? failure,
  }) {
    return ExideState(
      batteries: batteries ?? this.batteries,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
