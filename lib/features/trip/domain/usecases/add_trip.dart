import 'package:travel_app_rp/features/trip/domain/repositories/trip_repository.dart';

import '../entities/trip.dart';

class AddTrip {
  final TripRepository repository;

  AddTrip(this.repository);

  Future<void> call(Trip trip) {
    return repository.addTrip(trip);
  }
}


/*
Summary

The AddTrips use case encapsulates the business logic 
for adding a new Trip object to the data source. It 
serves as a mediator between the presentation layer 
(e.g., a UI component) and the data layer (the 
TripRepository).

*/
