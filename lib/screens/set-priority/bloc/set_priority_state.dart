part of 'set_priority_bloc.dart';

enum PriortyStatus { initial, loading, succuss, error }

class SetPriorityState extends Equatable {
  final List<Battery?> batteries;
  final Failure failure;
  final PriortyStatus status;

  const SetPriorityState({
    required this.batteries,
    required this.failure,
    required this.status,
  });

  factory SetPriorityState.initial() => SetPriorityState(
      batteries: [], failure: Failure(), status: PriortyStatus.initial);

  @override
  List<Object?> get props => [batteries, failure, status];
  @override
  bool? get stringify => true;

  SetPriorityState copyWith({
    List<Battery?>? batteries,
    Failure? failure,
    PriortyStatus? status,
  }) {
    return SetPriorityState(
      batteries: batteries ?? this.batteries,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
