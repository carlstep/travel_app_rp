import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app_rp/features/trip/presentation/providers/trip_provider.dart';

import 'add_trip_screen.dart';
import 'my_trip_screen.dart';

class MainScreen extends ConsumerWidget {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);
  String profilPic =
      "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(tripListNotifierProvider.notifier).loadTrips();

    _pageController.addListener(() {
      _currentPage.value = _pageController.page!.round();
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 100,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome...'),
            Text(
              'Where will you go today?',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.network(
                profilPic,
                fit: BoxFit.cover,
                height: 60,
                width: 60,
              ),
            ),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          MyTripScreen(),
          AddTripScreen(),
          Text('3'),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: _currentPage,
          builder: (context, pageIndex, child) {
            return BottomNavigationBar(
              currentIndex: pageIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'My Trips',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Add Trips',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.map),
                  label: 'Maps',
                ),
              ],
              onTap: (index) => _pageController.jumpToPage(index),
            );
          }),
    );
  }
}
