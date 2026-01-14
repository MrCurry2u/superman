import 'package:flutter/material.dart';
import '../services/mock_api.dart';
import '../models/event.dart';
import '../widgets/event_detail.dart';

class LiveFeedWidget extends StatefulWidget {
  const LiveFeedWidget({super.key});

  @override
  State<LiveFeedWidget> createState() => _LiveFeedWidgetState();
}

class _LiveFeedWidgetState extends State<LiveFeedWidget> {
  late Future<List<Event>> _eventsFuture;

  @override
  void initState() {
    super.initState();
    _eventsFuture = MockApi.getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
      future: _eventsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final events = snapshot.data ?? [];
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: events.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final e = events[i];
            return Card(
              child: ListTile(
                title: Text(e.summary),
                subtitle: Text('${e.timestamp} • ${e.locationSummary}'),
                trailing: e.hasAttachment ? const Icon(Icons.attachment) : null,
                onTap: () async {
                  showDialog(context: context, builder: (context) => EventDetailDialog(event: e));
                },
              ),
            );
          },
        );
      },
    );
  }
}