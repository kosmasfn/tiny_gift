import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiny_gift/domain/usecases/authenticate_user.dart';

class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final String token;
  Authenticated(this.token);
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class AuthEvent {}

class AuthenticateUserEvent extends AuthEvent {
  final String username;
  final String password;
  AuthenticateUserEvent(this.username, this.password);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticateUser authenticateUser;

  AuthBloc({required this.authenticateUser}) : super(AuthInitial()) {
  
    // Handle AuthenticateUserEvent
    on<AuthenticateUserEvent>((event, emit) async {
      // emit(AuthLoading()); // Emit loading state

      try {
        // Try to authenticate the user
        final token = await authenticateUser(AuthParams(username: event.username, password: event.password));
        emit(Authenticated(token)); // On success, emit authenticated state
      } catch (e) {
        emit(AuthFailure(e.toString())); // On error, emit error state
      }
    });
  }
}
