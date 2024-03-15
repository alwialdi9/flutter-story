part of 'models.dart';

class ApiReturnValue<T> {
  final T? value;
  final String? message;
  final bool? error;

  ApiReturnValue(
    {this.value, 
    this.message, 
    this.error}
  );
}