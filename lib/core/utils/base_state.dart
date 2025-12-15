import 'package:equatable/equatable.dart';
import 'package:mothea3_app/core/enums/request_status.dart';
import 'package:mothea3_app/core/network/exeptions/failure.dart';

class BaseState<T> extends Equatable {


  final RequestStatus requestStatus ; 

  final Failure failure ; 
  
  final T? data ; 

  const BaseState({
    this.requestStatus = RequestStatus.init,
    this.failure = const Failure("init Failure"),
    this.data
  });

  BaseState<T> copyWith({
    RequestStatus? requestStatus,
    Failure? failure,
    T? data,
  }) =>
      BaseState<T>(
        data: data ?? this.data,
        failure: failure ?? this.failure,
        requestStatus: requestStatus ?? this.requestStatus,
      );

  @override
  List<Object?> get props => [requestStatus , data , failure];

    BaseState<T> init() {
    return copyWith(requestStatus: RequestStatus.init);
  }

  // Returns a new BaseState object with the request status set to loading
  BaseState<T> loading() {
    return BaseState<T>(requestStatus: RequestStatus.loading, data: null);
  }

  // Returns a new BaseState object with the request status set to success and new data
  BaseState<T> success(T newData) {
    return copyWith(requestStatus: RequestStatus.success, data: newData);
  }

  BaseState<T> successNotNull(T newData) {
    return copyWith(requestStatus: RequestStatus.success, data: newData);
  }

  // Returns a new BaseState object with the request status set to error and new failure
  BaseState<T> error(Failure newFailure) {
    return copyWith(requestStatus: RequestStatus.error, failure: newFailure);
  }

  // Returns a new BaseState object with the request status set to error and a default failure
  BaseState<T> defaultError() {
    return copyWith(
      requestStatus: RequestStatus.error,
      failure: UnknownFailure(),
    );
  }

  // Returns a new BaseState object with all properties reset to their initial values
  BaseState<T> reset() => BaseState<T>();

  // check is loading
  bool get isLoading => requestStatus == RequestStatus.loading;

  // check is success
  bool get isSuccess => requestStatus == RequestStatus.success;

  // check is init
  bool get isInit => requestStatus == RequestStatus.init;

  // check is error
  bool get isError => requestStatus == RequestStatus.error;

  // get state failure package
  String get errorMessage => failure.message;

  // null data
  BaseState<T> dataNull({
    RequestStatus? requestStatus,
    Failure? failure,
  }) {
    return BaseState<T>(
      data: null,
      requestStatus: requestStatus ?? this.requestStatus,
      failure: failure ?? this.failure,
    );
  }

}