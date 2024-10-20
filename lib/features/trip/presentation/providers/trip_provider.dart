import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/data_source/trip_local_datasource.dart';
import '../../data/models/trip_model.dart';
import '../../data/repositories/trip_repository_impl.dart';
import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';
import '../../domain/usecases/add_trip.dart';
import '../../domain/usecases/delete_trip.dart';
import '../../domain/usecases/get_all_trips.dart';

// The code below defines several providers using Provider
// from flutter_riverpod. Providers allow you to declare
// and share objects throughout your application.

// Data Source Provider:
/*
It creates a provider for TripLocalDataSource.
When requested, it opens a Hive box named "trips" 
(where TripModel objects are stored) and returns 
an instance of TripLocalDataSource.
*/
final tripLocalDataSourceProvider = Provider<TripLocalDataSource>((ref) {
  final Box<TripModel> tripBox = Hive.box('trips');
  return TripLocalDataSource(tripBox);
});

// Repository Provider:
/*
It depends on the tripLocalDataSourceProvider.
When requested, it uses the retrieved TripLocalDataSource 
to create and return an instance of TripRepositoryImpl 
*/
final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final localDataSource = ref.read(tripLocalDataSourceProvider);
  return TripRepositoryImpl(localDataSource);
});

// USECASE PROVIDERS
// The code defines providers for each usecase.

// addTripProvider: Provides an instance of AddTrips that
// injects the TripRepository from the tripRepositoryProvider.
final addTripProvider = Provider<AddTrip>((ref) {
  final repository = ref.read(tripRepositoryProvider);

  return AddTrip(repository);
});

// getTripsProvider: Provides an instance of GetAllTrips
// that injects the TripRepository.
final getTripsProvider = Provider<GetAllTrips>((ref) {
  final repository = ref.read(tripRepositoryProvider);

  return GetAllTrips(repository);
});

// deleteTripProvider: Provides an instance of DeleteTrip
// that injects the TripRepository.
final deleteTripProvider = Provider<DeleteTrip>((ref) {
  final repository = ref.read(tripRepositoryProvider);

  return DeleteTrip(repository);
});

/*
You can leverage the providers above in UI components.
Use ConsumerWidget or Consumer to access the provided 
objects and build your UI based on them. Invoke use cases 
using the provided instances to handle user interactions 
and update data. By following these principles, you create 
a maintainable and scalable application using Riverpod 
for dependency injection and state management.
*/

// tripListNotifierProvider:
/*
This defines a new provider using StateNotifierProvider. 
It will manage a list of Trip objects and provide methods 
to interact with them.  Inside the provider function:
It reads the getTripsProvider, addTripProvider, and 
deleteTripProvider to obtain instances of the corresponding 
use cases. It creates and returns a TripListNotifier object, 
injecting the use case instances.
*/
final tripListNotifierProvider =
    StateNotifierProvider<TripListNotifier, List<Trip>>((ref) {
  final getTrips = ref.read(getTripsProvider);
  final addTrip = ref.read(addTripProvider);
  final deleteTrip = ref.read(deleteTripProvider);

  return TripListNotifier(getTrips, addTrip, deleteTrip);
});

// TripListNotifier Class:
/*
This class extends StateNotifier<List<Trip>>. It holds private 
references to the injected use cases (_getAllTrips, _addTrip, 
_deleteTrip) for better code organization. The constructor 
initializes the state (super([])) with an empty list of trips.
It defines methods for interacting with the data:
- addNewTrip(Trip trip): Calls the _addTrip use case to 
add a new trip.
- removeTrip(int tripId): Calls the _deleteTrip use case 
to remove a trip by its ID.
- loadTrips(): Calls the _getAllTrips use case to load the 
list of trips.
*/
class TripListNotifier extends StateNotifier<List<Trip>> {
  final GetAllTrips _getAllTrips;
  final AddTrip _addTrip;
  final DeleteTrip _deleteTrip;

  TripListNotifier(this._getAllTrips, this._addTrip, this._deleteTrip)
      : super([]);

  Future<void> addNewTrip(Trip trip) async {
    await _addTrip(trip);
  }

  Future<void> removeTrip(int tripId) async {
    await _deleteTrip(tripId);
  }

  Future<void> loadTrips() async {
    final tripsOrFailure = await _getAllTrips();
    tripsOrFailure.fold((error) => state = [], (trips) => state = trips);
  }
}
