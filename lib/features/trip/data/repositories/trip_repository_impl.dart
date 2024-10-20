import 'package:dartz/dartz.dart';
import 'package:travel_app_rp/core/error/failures.dart';
import 'package:travel_app_rp/features/trip/data/data_source/trip_local_datasource.dart';
import 'package:travel_app_rp/features/trip/data/models/trip_model.dart';
import 'package:travel_app_rp/features/trip/domain/entities/trip.dart';

import '../../domain/repositories/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource localDataSource;

  TripRepositoryImpl(
    this.localDataSource,
  );

  @override
  Future<void> addTrip(Trip trip) async {
    final tripModel = TripModel.fromEntity(trip);
    localDataSource.addTrip(tripModel);
  }

  @override
  Future<void> deleteTrip(int index) async {
    localDataSource.deleteTrip(index);
  }

  @override
  Future<Either<Failure, List<Trip>>> getAllTrips() async {
    try {
      final tripModel = localDataSource.getAllTrips();
      List<Trip> res = tripModel.map((model) => model.toEntity()).toList();
      return Right(res);
    } catch (err) {
      return Left(SomeSpecificError(err.toString()));
    }
  }
}
