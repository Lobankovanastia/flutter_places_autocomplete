part of flutter_places_autocomplete;

class PlacesAutocomplete implements PlacesAutocompleteEntity {
  final String apiKey;
  final String language;
  final String BASE_PLACE_API =
      'https://maps.googleapis.com/maps/api/geocode/json';
  final String BASE_GEOLOCATION_API =
      'https://maps.googleapis.com/maps/api/place/details/json';

  PlacesAutocomplete({
    @required this.apiKey,
    this.language = 'en',
  });

  Future<List<Prediction>> getPreditcions({
    String language,
    String location,
    bool strictbounds,
    List<String> types,
    @required String input,
  }) async {
    final response = await Http.post(
      BASE_PLACE_API,
      body: {
        'langage': language ?? this.language,
        'location': location,
        'strictbounds': strictbounds,
        'types': types,
        'inpuit': input,
        'key': apiKey,
      },
    );

    final predictionJson = JSON.jsonDecode(response.body);

    final Geolocation geolocation =
        await getGeolocation(placeId: predictionJson['place_id']);

    final result = (predictionJson as List).map((prediction) =>
        Prediction.fromJSON(prediction, geolocation.locationAsString()));

    if (predictionJson['status'] != 'OK') {
      switch (predictionJson['status']) {
        case 'UNKNOWN_ERROR':
          throw ServerException();
        case 'ZERO_RESULTS':
        case 'NOT_FOUND':
          throw ZeroResultsException();
        case 'OVER_QUERY_LIMIT':
          throw OverLimitException();
        case 'REQUEST_DENIED':
          throw UnauthorizedException();
      }
    }

    return result as List;
  }

  Future<Geolocation> getGeolocation(
      {@required String placeId,
      String sessionToken,
      List<String> fields}) async {
    final response = await Http.post(
      BASE_GEOLOCATION_API,
      body: {
        'place_id': placeId,
        'langage': language,
        'fields': fields,
        'sessionToken': sessionToken,
        'key': apiKey,
      },
    );

    final json = JSON.jsonDecode(response.body);

    if (json['status'] != 'OK') {
      switch (json['status']) {
        case 'UNKNOWN_ERROR':
          throw ServerException();
        case 'ZERO_RESULTS':
        case 'NOT_FOUND':
          throw ZeroResultsException();
        case 'OVER_QUERY_LIMIT':
          throw OverLimitException();
        case 'REQUEST_DENIED':
          throw UnauthorizedException();
      }
    }

    return Geolocation.fromJSON(json);
  }
}
