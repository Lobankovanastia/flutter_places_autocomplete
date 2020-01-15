# flutter_places_autocomplete_example
## Getting Started

Given the following Widget with a TextField and a Button:

```
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
  ```

  You can use the `_fetchPredictions` to fetch and save on state the result for the location:

  ```
  Future<void> _fetchPredictions() async {
    setState(() async {
      predictions = await placesAutocomplete.getPreditcions(input: 'london');
    });
  }
```

You can display it on a ListView for example:

```
Widget _listView() {
    return ListView.builder(
        itemCount: predictions.length,
        itemBuilder: (BuildContext context, int index) {
          return new Text(predictions[index].description);
        });
  }
  ```