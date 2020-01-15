part of flutter_places_autocomplete;

abstract class PlacesAutocompleteEntity {
  Future<List<dynamic>> getPreditcions(
      {String language,
      String location,
      bool strictbounds,
      List<String> types,
      String input});

  Future<dynamic> getGeolocation({
    @required String placeId,
    String sessionToken,
    List<String> fields,
  });
}
