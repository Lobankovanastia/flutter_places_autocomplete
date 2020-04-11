part of flutter_places_autocomplete;

abstract class PredictionEntity {
  // Complete string format of the location
  String name;
  // Id to identify the location on google places api
  String placeId;
  // List of types of this location
  String types;


  Geolocation geolocation;

  PredictionEntity({this.name, this.placeId, this.types});
  PredictionEntity.fromJSON(
      Map<String, dynamic> place, Geolocation geolocation);
}

class Prediction extends PredictionEntity {
  Prediction({description, placeId, types, terms});

  Prediction.fromJSON(Map<String, dynamic> place) {
    this.name = place['name'];
    this.placeId = place['place_id'];
    this.types = (place['types'] as List).join(',');
    this.geolocation = Geolocation.fromJSON({'result': place}) ;
  }
}
