import 'package:hive/hive.dart';

import '../../domain/entities/trip.dart';

part 'trip_model.g.dart';

@HiveType(typeId: 0)
class TripModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final List<String> photos;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String location;

  TripModel({
    required this.title,
    required this.photos,
    required this.description,
    required this.date,
    required this.location,
  });

  // functions

  // Conversion from Entity to Model
  factory TripModel.fromEntity(Trip trip) => TripModel(
        title: trip.title,
        photos: trip.photos,
        description: trip.description,
        date: trip.date,
        location: trip.location,
      );

  // Conversion from Model to Entity
  Trip toEntity() => Trip(
        title: title,
        photos: photos,
        description: description,
        date: date,
        location: location,
      );
}



/*
Summary

Overall, the TripModel class acts as a bridge between 
Trip entities (domain layer) and Hive (data layer) in 
your travel app. It leverages Hive's capabilities for 
local storage while ensuring compatibility with your 
domain entities.

Mapping to Entity:
- The fromEntity factory constructor creates a TripModel 
object from a Trip entity. It maps the corresponding 
properties between the two classes.

- The toEntity method converts a TripModel object back 
to a Trip entity. This allows for seamless data 
conversion between the domain layer and the data layer.

*/