import 'attachment.dart';

class Event {
  final String id;
  final String summary;
  final DateTime timestamp;
  final double lat;
  final double lng;
  final List<Attachment> attachments;

  Event({required this.id, required this.summary, required this.timestamp, required this.lat, required this.lng, List<Attachment>? attachments}) : attachments = attachments ?? [];

  bool get hasAttachment => attachments.isNotEmpty;

  String get locationSummary => '(${lat.toStringAsFixed(4)}, ${lng.toStringAsFixed(4)})';

  @override
  String toString() => '$summary at $timestamp';
}
