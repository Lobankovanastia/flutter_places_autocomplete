part of flutter_places_autocomplete;

class PlacesAutocomplete implements PlacesAutocompleteEntity {
  final String apiKey;
  final String language;
  static const BASE_PLACE_DETAILS_API =
      'https://maps.googleapis.com/maps/api/place/details/json';
  static const BASE_PLACES_API =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  PlacesAutocomplete({
    @required this.apiKey,
    this.language = '',
  });

  Future<List<Prediction>> getPredictions({
    String location,
    String type,
    String sessiontoken,
    @required String input,
  }) async {
  	Uri uri = Uri.parse(BASE_PLACES_API);
    Map<String,String> params = {
		'location': location,
		'type': type,
		'input': input,
		'key': apiKey,
        'radius': 3000.toString(),
        'sessiontoken': sessiontoken
	};
    if (language != null) {
        params['language'] = language;
    }
  	Uri uriWithParams = uri.replace(queryParameters: params);
  	
  	//print(uriWithParams.toString());
  	
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

    Map<String, Prediction> result = Map.fromIterable(
        (predictionJson['predictions'] as List).map(
            (prediction) =>  Prediction.fromJSON(prediction)
        ),
        key: (v) => v.name,
        value: (v) => v
    );
    
    return result.values.toList();
  }

    Future<Geolocation> getGeolocation({
        @required String placeId,
        String sessionToken,
        List<String> fields
    }) async {
    
        Uri uri = Uri.parse(BASE_PLACE_DETAILS_API);
        Map<String,String> params = {
            'place_id': placeId,
            'fields': fields.join(','),
            'sessiontoken': sessionToken,
            'key': apiKey,
        };
        if (language != null) {
            params['language'] = language;
        }
        
        Uri uriWithParams = uri.replace(queryParameters: params);
        //print(uriWithParams.toString());
        final response = await Http.get(uriWithParams);
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
