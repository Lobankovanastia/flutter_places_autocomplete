import 'package:flutter_places_autocomplete/flutter_places_autocomplete.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Places Autocomplete',
      home: MyApp(),
    );
  }
}

class FlutterPlacesAutocompleteWidget extends StatefulWidget {
  FlutterPlacesAutocompleteWidget({Key key}) : super(key: key);

  @override
  _FlutterPlacesAutocompleteWidgetState createState() =>
      _FlutterPlacesAutocompleteWidgetState();
}

class _FlutterPlacesAutocompleteWidgetState
    extends State<FlutterPlacesAutocompleteWidget> {
  PlacesAutocomplete placesAutocomplete;
  List<Prediction> predictions;
  final searchController = TextEditingController();

  @override
  void initState() {
    placesAutocomplete =
        PlacesAutocomplete(apiKey: 'AIzaSyC-OHeGgrRHWqf3gkMWAKvd6yvJKpvv6xM');
    predictions = [];
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Places Autocomplete'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: searchController,
            ),
            RaisedButton(
              onPressed: _fetchPredictions,
              child: Text(
                'Search',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchPredictions() async {
    setState(() async {
      predictions = await placesAutocomplete.getPredictions(input: 'london');
    });
  }

  Widget _listView() {
    return ListView.builder(
        itemCount: predictions.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Text(predictions[index].description);
        });
  }
}
