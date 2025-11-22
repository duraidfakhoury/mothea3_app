part of "splash_bloc.dart";

sealed class SplashState extends Equatable {
  const SplashState();
}

class InitInProgress extends SplashState {
  final RequestStatus status ; 

  const InitInProgress({this.status = RequestStatus.loading});
  
  @override
  List<Object?> get props => [status];

}

class InitComplete extends SplashState {
  final RequestStatus status = RequestStatus.success ;
  final AuthStatus authStatus ;  

  const InitComplete({required this.authStatus});
  
  @override
  List<Object?> get props => [status , authStatus];

}