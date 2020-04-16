import 'package:flutter_places_autocomplete/flutter_places_autocomplete.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:mockito/mockito.dart' show when, Mock;

class MockPlacesAutocomplete extends Mock implements PlacesAutocomplete {}

void main() {
  final tGeolocation = Geolocation(
    'gfrgfrw'
  );

  final tPrediction = Prediction(
    name: 'London, UK',
    placeId: 'ChIJdd4hrwug2EcRmSrV3Vo6llI',
    types: ["locality", "political", "geocode"],
  );

  final tPredictions = [tPrediction];
  MockPlacesAutocomplete placesAutocomplete;

  group('Geolocation', () {
    test(
      'should return a subclass of GeolocationEntity',
      () async {
        expect(tGeolocation, isA<GeolocationEntity>());
      },
    );

    test('should return geolocation when all result is success', () async {
      final Map<String, dynamic> jsonMap = json.decode(
          '{"html_attributions": [],"result": {"geometry": {"location": {"lat": -12.2661261, "lng": -38.9355328},"viewport": {"northeast": {"lat": -12.2647771197085,"lng": -38.9341262197085},"southwest": {"lat": -12.2674750802915,"lng": -38.9368241802915}}}},"status": "OK"}');

      final result = Geolocation.fromJSON(jsonMap);
      expect(result, isA<GeolocationEntity>());
      //expect(result.lat, -12.2661261);
      //expect(result.lng, -38.9355328);
    });

    test('should return a string from geolocation', () async {
      final Map<String, dynamic> jsonMap = json.decode(
          '{"html_attributions": [],"result": {"geometry": {"location": {"lat": -12.2661261, "lng": -38.9355328},"viewport": {"northeast": {"lat": -12.2647771197085,"lng": -38.9341262197085},"southwest": {"lat": -12.2674750802915,"lng": -38.9368241802915}}}},"status": "OK"}');

      final result = Geolocation.fromJSON(jsonMap);

      expect(result.locationAsString, '-12.2661261,-38.9355328');
    });
  });

  group('Places', () {
    setUp(() {
      placesAutocomplete = MockPlacesAutocomplete();
    });

    group(
      'when getGeolocation',
      () {
        test('should return place data when success', () async {
          when(placesAutocomplete.getGeolocation(placeId: tPrediction.placeId))
              .thenAnswer((_) async => tGeolocation);

          final result = await placesAutocomplete.getGeolocation(
              placeId: tPrediction.placeId);

          //expect(result.lat, tGeolocation.lat);
          //expect(result.lng, tGeolocation.lng);
        });

        test('should return exception when server error', () async {
          when(placesAutocomplete.getGeolocation(placeId: tPrediction.placeId))
              .thenThrow(ServerException());

          try {
            await placesAutocomplete.getGeolocation(
              placeId: tPrediction.placeId,
            );
          } on ServerException catch (e) {
            expect(e, isA<ServerException>());
            expect(e.errorMessage, 'Server error, try again!');
          }
        });

        test('should return exception when no results returned', () async {
          when(placesAutocomplete.getGeolocation(placeId: tPrediction.placeId))
              .thenThrow(ZeroResultsException());

          try {
            await placesAutocomplete.getGeolocation(
              placeId: tPrediction.placeId,
            );
          } on ZeroResultsException catch (e) {
            expect(e, isA<ZeroResultsException>());
            expect(e.errorMessage, 'There are no results for this search!');
          }
        });

        test('should return exception when places api reached limit', () async {
          when(placesAutocomplete.getGeolocation(placeId: tPrediction.placeId))
              .thenThrow(OverLimitException());

          try {
            await placesAutocomplete.getGeolocation(
              placeId: tPrediction.placeId,
            );
          } on OverLimitException catch (e) {
            expect(e, isA<OverLimitException>());
            expect(e.errorMessage,
                'You have exceeded your daily request limit or the billing is not enabled on that project!');
          }
        });

        test('should return exception when key is invalid', () async {
          when(placesAutocomplete.getGeolocation(placeId: tPrediction.placeId))
              .thenThrow(UnauthorizedException());

          try {
            await placesAutocomplete.getGeolocation(
              placeId: tPrediction.placeId,
            );
          } on UnauthorizedException catch (e) {
            expect(e, isA<UnauthorizedException>());
            expect(e.errorMessage, 'Unauthorized, check you aplication key!');
          }
        });
      },
    );

    group(
      'when getPredictions',
      () {
        setUp(() {
          placesAutocomplete = MockPlacesAutocomplete();
        });

        test('should return place data when success', () async {
          when(placesAutocomplete.getPredictions(input: 'london'))
              .thenAnswer((_) async => tPredictions);

          final result =
              await placesAutocomplete.getPredictions(input: 'london');

          expect(result[0].placeId, tPrediction.placeId);
        });

        test('should return exception when no results returned', () async {
          when(placesAutocomplete.getPredictions(input: 'london'))
              .thenThrow(ZeroResultsException());

          try {
            await placesAutocomplete.getPredictions(input: 'london');
          } on ZeroResultsException catch (e) {
            expect(e, isA<ZeroResultsException>());
            expect(e.errorMessage, 'There are no results for this search!');
          }
        });

        test('should return exception when server error', () async {
          when(placesAutocomplete.getPredictions(input: 'london'))
              .thenThrow(ServerException());

          try {
            await placesAutocomplete.getPredictions(input: 'london');
          } on ServerException catch (e) {
            expect(e, isA<ServerException>());
            expect(e.errorMessage, 'Server error, try again!');
          }
        });

        test('should return exception when places api reached limit', () async {
          when(placesAutocomplete.getPredictions(input: 'london'))
              .thenThrow(OverLimitException());

          try {
            await placesAutocomplete.getPredictions(input: 'london');
          } on OverLimitException catch (e) {
            expect(e, isA<OverLimitException>());
            expect(e.errorMessage,
                'You have exceeded your daily request limit or the billing is not enabled on that project!');
          }
        });

        test('should return exception when key is invalid', () async {
          when(placesAutocomplete.getPredictions(input: 'london'))
              .thenThrow(UnauthorizedException());

          try {
            await placesAutocomplete.getPredictions(input: 'london');
          } on UnauthorizedException catch (e) {
            expect(e, isA<UnauthorizedException>());
            expect(e.errorMessage, 'Unauthorized, check you aplication key!');
          }
        });
      },
    );
  });
}
