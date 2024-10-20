import 'package:dartz/dartz.dart';
import 'package:travel_app_rp/features/trip/domain/repositories/trip_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/trip.dart';

class GetAllTrips {
  final TripRepository repository;

  GetAllTrips(this.repository);

  Future<Either<Failure, List<Trip>>> call() {
    return repository.getAllTrips();
  }
}



/*
Summary

The GetAllTrips use case encapsulates the business 
logic for retrieving a list of all Trip objects from 
the data source. It serves as a mediator between the 
presentation layer (e.g., a UI component) and the 
data layer (the TripRepository).

*/