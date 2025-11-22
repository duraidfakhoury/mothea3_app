import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothea3_app/core/enums/auth_status.dart';
import 'package:mothea3_app/core/enums/request_status.dart';
import 'package:mothea3_app/modules/auth/domain/repository/auth_repository.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent,SplashState> {
  final AuthRepository authRepository ; 

  SplashBloc({required AuthRepository auth }) 
   : authRepository = auth ,
   super(InitInProgress()) {
    on<AppStarted> (_onAppStarted);
   }
  void _onAppStarted (AppStarted event , emit ) async {
    await Future.delayed(Duration(seconds: 5));
    final status = await authRepository.checkAuthentication();
    emit(InitComplete(authStatus: status));
  }
}