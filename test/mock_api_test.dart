import 'package:flutter_test/flutter_test.dart';
import 'package:the_lions_eye/services/mock_api.dart';

void main() {
  group('MockApi', () {
    test('getEvents returns events and eventIds are present', () async {
      final events = await MockApi.getEvents();
      expect(events, isNotEmpty);
      // check expected IDs exist
      final ids = events.map((e) => e.id).toList();
      expect(ids, contains('e1'));
      expect(ids, contains('e2'));
      expect(ids, contains('e3'));
    });

    test('getEventById returns the correct event', () async {
      final e = await MockApi.getEventById('e1');
      expect(e, isNotNull);
      expect(e!.id, 'e1');
      expect(e.hasAttachment, isTrue);
    });

    test('getVaultFiles returns a list', () async {
      final files = await MockApi.getVaultFiles();
      expect(files, isNotEmpty);
    });

    test('getBreadcrumbs includes eventId entries', () async {
      final crumbs = await MockApi.getBreadcrumbs();
      // some breadcrumbs should include an eventId per mock design
      final withEvent = crumbs.where((c) => c.containsKey('eventId')).toList();
      expect(withEvent.length, greaterThanOrEqualTo(1));
    });
  });
}
