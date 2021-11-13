part of 'luminous_bloc.dart';

enum LuminousStatus { initial, loading, loaded, error }

class LuminousState extends Equatable {
  final List<Battery?> batteries;
  final LuminousStatus status;
  final Failure failure;

  const LuminousState({
    required this.batteries,
    required this.status,
    required this.failure,
  });

  @override
  List<Object> get props => [batteries, status, failure];

  LuminousState copyWith({
    List<Battery?>? batteries,
    LuminousStatus? status,
    Failure? failure,
  }) {
    return LuminousState(
      batteries: batteries ?? this.batteries,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  factory LuminousState.initial() => LuminousState(
      batteries: [], status: LuminousStatus.initial, failure: Failure());
  @override
  bool get stringify => true;
}
