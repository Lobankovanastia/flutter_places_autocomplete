part of flutter_places_autocomplete;

abstract class BaseException implements Exception {
  get errorMessage;
}

class ServerException implements BaseException {
  @override
  get errorMessage => 'Server error, try again!';
}

class ZeroResultsException implements BaseException {
  @override
  get errorMessage => 'There are no results for this search!';
}

class OverLimitException implements BaseException {
  @override
  get errorMessage =>
      'You have exceeded your daily request limit or the billing is not enabled on that project!';
}

class UnauthorizedException implements BaseException {
  @override
  get errorMessage => 'Unauthorized, check you aplication key!';
}
