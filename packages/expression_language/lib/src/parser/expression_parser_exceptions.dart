abstract class ExpressionParserException implements Exception {
  final String message;
  ExpressionParserException(this.message);
  String getMessage() => message;

  @override
  String toString() {
    return '${super.toString()}, Message: $message';
  }
}

class InvalidSyntaxException extends ExpressionParserException {
  InvalidSyntaxException(super.message);
}

class DivideByZeroException extends ExpressionParserException {
  DivideByZeroException(super.message);
}

class NullReferenceException extends ExpressionParserException {
  NullReferenceException(super.message);
}

class UnknownExpressionTypeException extends ExpressionParserException {
  UnknownExpressionTypeException(super.message);
}

class UnknownFunctionException extends ExpressionParserException {
  UnknownFunctionException(super.message);
}

class UnknownConstantTypeException extends ExpressionParserException {
  UnknownConstantTypeException(super.message);
}

class UnknownExpressionFactoryException extends ExpressionParserException {
  UnknownExpressionFactoryException(super.message);
}

class InvalidParameterException extends ExpressionParserException {
  InvalidParameterException(super.message);
}

class InvalidParameterCount extends ExpressionParserException {
  InvalidParameterCount(super.message);
}

class InvalidRegularExpressionException extends ExpressionParserException {
  InvalidRegularExpressionException(super.message);
}
