import 'dart:developer';

import 'package:asl/models/models.dart';
import 'package:asl/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> signIn(String email, String password) async {
    emit(UserLoading());
    try {
      ApiReturnValue<Map<String, dynamic>> user =
          await UserService.signIn(email, password);

      bool? error = user.error;
      if (error!) {
        emit(UserFailedLogin(user.message!));
      } else {
        if (user.value != null) {
          emit(UserSuccessLogin(token: user.value?['token']));
        } else {
          emit(UserFailedLogin(user.message!));
        }
      }
    } catch (e) {
      log("[${DateTime.now()}] Error : $e");
      emit(UserFailedLogin(e.toString()));
    }
  }
}
