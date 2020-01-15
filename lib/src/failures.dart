part of flutter_places_autocomplete;

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super();

  @override
  List<Object> get props => null;
}

class FormatFailure extends Failure {}
