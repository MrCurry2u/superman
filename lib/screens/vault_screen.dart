import 'package:flutter/material.dart';
import '../services/mock_api.dart';

class VaultScreen extends StatelessWidget {
  const VaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: MockApi.getVaultFiles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        final files = snapshot.data ?? [];
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: files.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final f = files[i];
            return ListTile(
              leading: const Icon(Icons.insert_drive_file),
              title: Text(f['name'] ?? 'file'),
              subtitle: Text(f['type'] ?? ''),
              trailing: TextButton(onPressed: () {}, child: const Text('Download')),
            );
          },
        );
      },
    );
  }
}
