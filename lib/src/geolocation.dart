part of flutter_places_autocomplete;

class GeolocationEntity {
  double lat;
  double lng;
  Map<String, dynamic> geolocation;

  GeolocationEntity(this.lat, this.lng);
  GeolocationEntity.fromJSON(Map<String, dynamic> geolocation);
}

class Geolocation extends GeolocationEntity {
  Geolocation(lat, lng) : super(lat, lng);

  Geolocation.fromJSON(Map<String, dynamic> geolocation)
      : super(geolocation["result"]["geometry"]["location"]['lat'],
            geolocation["result"]["geometry"]["location"]['lng']);

  get locationAsString {
    return '$lat,$lng';
  }
}
