part of 'sky_bloc.dart';

enum SkyStatus { initial, loading, loaded, error }

class SkyState extends Equatable {
  final List<Battery?> batteries;
  final SkyStatus status;
  final Failure failure;

  SkyState({
    required this.batteries,
    required this.status,
    required this.failure,
  });

  @override
  List<Object?> get props => [batteries, status, failure];

  factory SkyState.initial() =>
      SkyState(batteries: [], status: SkyStatus.initial, failure: Failure());

  SkyState copyWith({
    List<Battery?>? batteries,
    SkyStatus? status,
    Failure? failure,
  }) {
    return SkyState(
      batteries: batteries ?? this.batteries,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
