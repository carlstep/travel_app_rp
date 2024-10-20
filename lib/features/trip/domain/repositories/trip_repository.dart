import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/trip.dart';

abstract class TripRepository {
  Future<Either<Failure, List<Trip>>> getAllTrips();
  Future<void> addTrip(Trip trip);
  Future<void> deleteTrip(int index);
}



/*
Summary

The trip_repository.dart file defines an abstract class named 
TripRepository. This class serves as an interface (contract) 
for interacting with trip data. It specifies the methods that 
any concrete implementation of this repository must provide.

In essence, the TripRepository acts as a bridge between the 
domain layer (where Trip objects reside) and the data layer 
(where the actual data is stored). It handles the low-level 
details of interacting with the data source, allowing the 
rest of your application to focus on business logic and user 
interface.

*/