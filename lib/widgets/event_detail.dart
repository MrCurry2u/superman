import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/event.dart';

class EventDetailDialog extends StatelessWidget {
  final Event event;
  final VoidCallback? onViewOnMap;

  const EventDetailDialog({super.key, required this.event, this.onViewOnMap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(event.summary),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Time: ${event.timestamp}'),
              const SizedBox(height: 8),
              Text('Location: ${event.locationSummary}'),
              const SizedBox(height: 12),
              const Text('Attachments:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              if (event.attachments.isEmpty) const Text('No attachments'),
              ...event.attachments.map((a) => ListTile(
                    leading: const Icon(Icons.attachment),
                    title: Text(a.name),
                    subtitle: Text('${a.mime} • ${a.sha256}'),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      TextButton(
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: a.url));
                          if (!context.mounted) return;
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Attachment URL copied')));
                        },
                        child: const Text('Copy URL'),
                      ),
                      const SizedBox(width: 8),
                      TextButton(onPressed: () {}, child: const Text('Download')),
                    ]),
                  )),
            ],
          ),
        ),
      ),
      actions: [
        if (onViewOnMap != null) TextButton(onPressed: () { Navigator.pop(context); onViewOnMap!(); }, child: const Text('View on Map')),
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
      ],
    );
  }
}
