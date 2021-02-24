abstract class Failure {}

class Error extends Failure {
  final String errMessage;

  Error({this.errMessage});

  @override
  String toString() {
    return 'Error ----->$errMessage';
  }
}
