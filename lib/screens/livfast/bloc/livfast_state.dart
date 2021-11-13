part of 'livfast_bloc.dart';

enum LivFastStatus { initial, loading, loaded, error }

class LivFastState extends Equatable {
  final List<Battery?> batteries;
  final LivFastStatus status;
  final Failure failure;
  LivFastState({
    required this.batteries,
    required this.status,
    required this.failure,
  });

  @override
  List<Object> get props => [batteries, status, failure];

  LivFastState copyWith({
    List<Battery?>? batteries,
    LivFastStatus? status,
    Failure? failure,
  }) {
    return LivFastState(
      batteries: batteries ?? this.batteries,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  factory LivFastState.initial() => LivFastState(
      batteries: [], status: LivFastStatus.initial, failure: Failure());

  @override
  bool get stringify => true;
}
