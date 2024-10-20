import 'package:hive_flutter/hive_flutter.dart';

import '../models/trip_model.dart';

class TripLocalDataSource {
  final Box<TripModel> tripBox;

  TripLocalDataSource(
    this.tripBox,
  );

  List<TripModel> getAllTrips() {
    return tripBox.values.toList();
  }

  addTrip(TripModel trip) {
    tripBox.add(trip);
  }

  deleteTrip(int index) {
    tripBox.deleteAt(index);
  }
}


/* 
Summary

The trip_local_datasource.dart file defines a 
class named TripLocalDataSource, which acts as 
a data source for interacting with Trip data 
stored in Hive.

The tripBox property is a Box<TripModel>, 
representing a container for storing TripModel 
objects in Hive.

Methods -
- getAllTrips(): This method retrieves all TripModel 
objects stored in the tripBox and returns them as a list.

- addTrip(TripModel trip): This method adds a new 
TripModel object to the tripBox.

- deleteTrip(int index): This method deletes the 
TripModel object at the specified index from the tripBox.


The TripLocalDataSource class serves as the bridge between the TripRepository 
and Hive. It encapsulates the details of interacting with Hive, making the 
TripRepository implementation more focused on the domain logic. Other parts of 
your application can use the TripLocalDataSource to store and retrieve Trip data 
locally.




*/