# flutter_places_autocomplete_example

A plugin that give you the access to google places api to search by geolocation and places to autocomplete.

## Features

* Generate a list of locations based on user input and optional parameters;
* Get Geolocation (lat, lng) from a place, based on place_id

## Usage

In order to use this plugin you need to add `flutter_places_autocomplete` to your `pubspec.yaml` file.

```
dependencies: 
    flutter_places_autocomplete: 0.1.0 
```

## Geolocation

You can get the place Geolocation by passing it's `placeId`. for example:

```
import 'package:flutter_places_autocomplete/flutter_places_autocomplete.dart';

Geolocation geolocation = await PacesAutocomplete(apikey: 'YOUR_API_KEY').getGeolocation(placeId: 'ChIJdd4hrwug2EcRmSrV3Vo6llI');
```

You can also retrive the the geolocation in string format `lat,lng`:

```
Geolocation geolocation = await PacesAutocomplete(apikey: 'YOUR_API_KEY').getGeolocation(placeId: 'ChIJdd4hrwug2EcRmSrV3Vo6llI');

geolocation.locationAsString;
```

You can also set optional parameters to the search

| Props        | Description                                                                   |
| ------------ | ----------------------------------------------------------------------------- |
| fields       | You can specify which fields of the search you want to bring.                 |
| sessionToken | A random string which identifies an autocomplete session for billing purposes |

*The Basic category includes the following fields:*
`address_component, adr_address, formatted_address, geometry, icon, name, permanently_closed, photo, place_id, plus_code, type, url, utc_offset, vicinity`

*The Contact category includes the following fields:*
`formatted_phone_number, international_phone_number, opening_hours, website`

*The Atmosphere category includes the following fields:*
` price_level, rating, review, user_ratings_total`

## Predictions

You can retrieve a list of possible predictions for an input. for example:

```
import 'package:flutter_places_autocomplete/flutter_places_autocomplete.dart';

Predictions predictions = await PacesAutocomplete(apikey: 'YOUR_API_KEY').gerPredictions(input: 'London');
```

It will retrieve a `List<Prediction>` which contains

| Prediction  | Description                                                            |
| ----------- | ---------------------------------------------------------------------- |
| description | The human-readable name for the returned result.                       |
| place_id    | A textual identifier that uniquely identifies a place.                 |
| types       | An array of types that apply to this place.                            |
| terms       | An array of terms identifying each section of the returned description |
| geolocation | A geolocation object containing lat, lng for the place                 |

You can set the following parameters:

| Props        | Description                                                                                  |
| ------------ | -------------------------------------------------------------------------------------------- |
| language     | The language code, indicating in which language the results should be returned               |
| location     | The point around which you wish to retrieve place information. Must be specified as lat,lng. |
| types        | The types of place results to return.                                                        |
| strictbounds | Places that are strictly within the region defined by location and radius                    |

