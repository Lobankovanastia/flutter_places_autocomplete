part of flutter_places_autocomplete;

abstract class PredictionEntity {
  // Complete string format of the location
  String name;
  // Id to identify the location on google places api
  String placeId;
  // List of types of this location
  String types;


  PredictionEntity({this.name, this.placeId, this.types});
  PredictionEntity.fromJSON(
      Map<String, dynamic> place);
}

class Prediction extends PredictionEntity {
  Prediction({name, placeId, types});

  Prediction.fromJSON(Map<String, dynamic> place) {
    this.name = (place["structured_formatting"] as Map<String, dynamic>)['main_text'].toString();
    this.placeId = place['place_id'];
    this.types = (place['types'] as List).join(',');
  }
}
