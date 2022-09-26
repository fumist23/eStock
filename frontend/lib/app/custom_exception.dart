class CustomException implements Exception {
  final String? message;
  const CustomException({this.message = 'Something went wrong!'});

  @override
  String toString() { 
    'CustomExceptio {message: $message}';
    return super.toString();
  }
}
