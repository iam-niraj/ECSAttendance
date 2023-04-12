part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final List<String> attendance;
  final HomeStatus status;
  const HomeState({
    this.attendance = const [],
    this.status = HomeStatus.initial,
  });

  HomeState copywith(
      {List<String> Function()? attendance, HomeStatus Function()? status}) {
    return HomeState(
      attendance: attendance != null ? attendance() : this.attendance,
      status: status != null ? status() : this.status,
    );
  }

  @override
  List<Object?> get props => [
        attendance,
        status,
      ];
}
