part of flutter_places_autocomplete;

abstract class PredictionEntity {
  // Complete string format of the location
  String description;
  // Id to identify the location on google places api
  String placeId;
  // List of types of this location
  String types;
  // Description separated by items
  List<String> terms;

  Geolocation geolocation;

  PredictionEntity({this.description, this.placeId, this.types, this.terms});
  PredictionEntity.fromJSON(
      Map<String, dynamic> place, Geolocation geolocation);
}

class Prediction extends PredictionEntity {
  Prediction({description, placeId, types, terms});

  Prediction.fromJSON(Map<String, dynamic> place, Geolocation geolocation) {
    this.description = place['description'];
    this.placeId = place['place_id'];
    this.types = (place['types'] as List).join(',');
    this.terms = (place['terms'] as List).map((term) => term.value).toList();
    this.geolocation = geolocation;
  }
}
