part of flutter_places_autocomplete;

class GeolocationEntity {
  
  String address;
  

  GeolocationEntity(this.address);
  GeolocationEntity.fromJSON(Map<String, dynamic> geolocation);
}

class Geolocation extends GeolocationEntity {
  Geolocation(address) : super(address);

  Geolocation.fromJSON(Map<String, dynamic> geolocation)
      : super(geolocation["result"]["formatted_address"]);

  get locationAsString {
    return '$address';
  }
}
