part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserSuccessLogin extends UserState {
  final String token;
  const UserSuccessLogin({required this.token});

  @override
  List<Object> get props => [token];
}
final class UserFailedLogin extends UserState {
  final String message;
  const UserFailedLogin(this.message);

  @override
  List<Object> get props => [message];
}
final class UserLoading extends UserState {}
