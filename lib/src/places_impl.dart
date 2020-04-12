part of flutter_places_autocomplete;

class PlacesAutocomplete implements PlacesAutocompleteEntity {
  final String apiKey;
  final String language;
  static const BASE_GEOLOCATION_API =
      'https://maps.googleapis.com/maps/api/geocode/json';
  static const BASE_PLACES_API =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  PlacesAutocomplete({
    @required this.apiKey,
    this.language = 'en',
  });

  Future<List<Prediction>> getPredictions({
    String language,
    String location,
    String type,
    @required String input,
  }) async {
  	Uri uri = Uri.parse(BASE_PLACES_API);
    Map<String,String> params = {
		'language': language ?? this.language,
		'location': location,
		'type': type,
		'input': input,
		'key': apiKey,
	};
  	Uri uriWithParams = uri.replace(queryParameters: params);
  	print(uriWithParams.toString());
    final response = await Http.get(uriWithParams);

    final predictionJson = JSON.jsonDecode(response.body);

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
  
    final result = (predictionJson['predictions'] as List).map(
		    (prediction) => Prediction.fromJSON(prediction)
    ).toList();

    return result;
  }

    Future<Geolocation> getGeolocation({
        @required String placeId,
        String sessionToken,
        List<String> fields
    }) async {
        final response = await Http.post(
            BASE_GEOLOCATION_API,
            body: {
                'place_id': placeId,
                'language': language,
                'fields': fields,
                'sessionToken': sessionToken,
                'key': apiKey,
            },
        );
        
        final json = JSON.jsonDecode(response.body);
        _checkStatus(json['status']);
        
        return Geolocation.fromJSON(json);
    }
  
  
    void _checkStatus(String status) {
        if (status != 'OK') {
            switch (status) {
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
    }
}
