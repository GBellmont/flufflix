import 'package:flufflix/app/core/error/app_error.dart';

class AppResponse<T> {
  final T? success;
  final AppError? error;

  AppResponse({this.success, this.error});

  bool get hasError => error != null;
}
