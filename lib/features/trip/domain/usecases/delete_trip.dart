import 'package:travel_app_rp/features/trip/domain/repositories/trip_repository.dart';

class DeleteTrip {
  final TripRepository repository;

  DeleteTrip(this.repository);

  Future<void> call(int index) {
    return repository.deleteTrip(index);
  }
}




/*
Summary

The DeleteTrip use case encapsulates the business 
logic for deleting an existing Trip object from 
the data source. It serves as a mediator between 
the presentation layer (e.g., a UI component) and 
the data layer (the TripRepository).

*/