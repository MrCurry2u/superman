import 'dart:async';
import '../models/event.dart';
import '../models/attachment.dart';

class MockApi {
  static Future<List<Event>> getEvents() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      Event(
        id: 'e1',
        summary: 'Subject arrived at location',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        lat: 37.7749,
        lng: -122.4194,
        attachments: [
          Attachment(name: 'photo_1.jpg', mime: 'image/jpeg', url: 'https://example.com/photo_1.jpg', sha256: 'abc123'),
        ],
      ),
      Event(
        id: 'e2',
        summary: 'Vehicle parked nearby',
        timestamp: DateTime.now().subtract(const Duration(minutes: 50)),
        lat: 37.7750,
        lng: -122.4185,
      ),
      Event(
        id: 'e3',
        summary: 'Signed affidavit uploaded',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        lat: 37.7740,
        lng: -122.4170,
        attachments: [
          Attachment(name: 'affidavit.pdf', mime: 'application/pdf', url: 'https://example.com/affidavit.pdf', sha256: 'def456'),
        ],
      ),
    ];
  }

  static Future<Event?> getEventById(String id) async {
    final events = await getEvents();
    try {
      return events.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  static Future<List<Map<String, String>>> getVaultFiles() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      {'name': 'Affidavit_2026-01-10.pdf', 'type': 'PDF'},
      {'name': 'Surveillance_Short.mp4', 'type': 'Video'},
      {'name': 'Contract_signed.pdf', 'type': 'PDF'},
    ];
  }

  static Future<List<Map<String, dynamic>>> getBreadcrumbs() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final now = DateTime.now();
    // attach eventId to some breadcrumbs to enable detail linking
    return List.generate(8, (i) {
      final map = {
        'lat': 37.7740 + i * 0.0005,
        'lng': -122.4190 + i * 0.0006,
        'timestamp': now.subtract(Duration(minutes: i * 10)),
      };
      if (i == 0) map['eventId'] = 'e1';
      if (i == 3) map['eventId'] = 'e3';
      return map;
    });
  }
}
