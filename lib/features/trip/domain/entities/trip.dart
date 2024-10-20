class Trip {
  final String title;
  final List<String> photos; // photos the users adds for the trip
  final String description;
  final DateTime date;
  final String location;

  Trip({
    required this.title,
    required this.photos,
    required this.description,
    required this.date,
    required this.location,
  });
}



/* 
Summary:

The Trip class represents a trip entity in your travel app.
It has properties for title, photos, description, date, and 
location. The constructor ensures that all properties are 
provided when creating a new Trip object.

*/