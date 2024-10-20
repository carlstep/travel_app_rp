import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app_rp/features/trip/domain/entities/trip.dart';
import 'package:travel_app_rp/features/trip/presentation/providers/trip_provider.dart';

class AddTripScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: 'City 1');
  final _descriptionController = TextEditingController(text: 'City 1');
  final _photosController = TextEditingController(text: 'City 1');
  final _locationController = TextEditingController(text: 'City 1');
  List<String> pictures = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Trip Title',
                hintText: 'enter a title for the trip...',
              ),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                  labelText: 'Trip Description',
                  hintText: 'enter a description for the trip...'),
            ),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                  labelText: 'Trip Location',
                  hintText: 'enter a location for the trip...'),
            ),
            TextFormField(
              controller: _photosController,
              decoration: const InputDecoration(
                  labelText: 'Trip Photos',
                  hintText: 'add photos for the trip'),
            ),
            const Expanded(
              child: SizedBox(
                height: 20,
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * 1, 50)),
              onPressed: () {
                pictures.add(_photosController.text);
                if (_formKey.currentState!.validate()) {
                  final newTrip = Trip(
                    title: _titleController.text,
                    photos: pictures,
                    description: _descriptionController.text,
                    date: DateTime.now(),
                    location: _locationController.text,
                  );
                  ref
                      .read(tripListNotifierProvider.notifier)
                      .addNewTrip(newTrip);
                  ref.watch(tripListNotifierProvider.notifier).loadTrips();
                }
              },
              child: const Text('Add Your Trip'),
            ),
          ],
        ),
      ),
    );
  }
}
