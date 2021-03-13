abstract class Failure {
  String get message => null;
}

class Error extends Failure {
  final String errMessage;

  Error({this.errMessage});

  @override
  String toString() {
    return 'Error ----->$errMessage';
  }
}
