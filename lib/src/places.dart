part of flutter_places_autocomplete;

abstract class PlacesAutocompleteEntity {
  Future<List<dynamic>> getPredictions({
      String location,
      String type,
      String input
  });

  Future<dynamic> getGeolocation({
    @required String placeId,
    String sessionToken,
    List<String> fields,
  });
}
