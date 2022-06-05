import 'package:cap_member_app/models/event_model.dart';
import 'package:cap_member_app/services/cap_service.dart';
import 'package:flutter/material.dart';

class Events extends StatelessWidget {
  Events({Key? key}) : super(key: key);

  final capService = CapService();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('試合結果'),
        flexibleSpace: GestureDetector(
          onTap: () {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder<List<EventModel>>(
          // future: capService.getGameResults(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<EventModel> events = snapshot.data!;

              return ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 15),
                itemCount: 100,
                itemBuilder: (_, index) => Container(
                  child: Text(events[index].eventName),
                ),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
