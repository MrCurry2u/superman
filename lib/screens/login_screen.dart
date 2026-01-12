import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to The Lions Eye', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('Prototype biometric login (mock)'),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.fingerprint),
              label: const Text('Use Biometric (Mock)'),
              onPressed: () async {
                // In a real app, call local_auth and handle fallback.
                final prefs = await SharedPreferences.getInstance();
                final accepted = prefs.getBool('accepted_terms') ?? false;
                if (accepted) {
                  Navigator.of(context).pushReplacementNamed('/case');
                } else {
                  Navigator.of(context).pushReplacementNamed('/consent');
                }
              },
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                final accepted = prefs.getBool('accepted_terms') ?? false;
                if (accepted) {
                  Navigator.of(context).pushReplacementNamed('/case');
                } else {
                  Navigator.of(context).pushReplacementNamed('/consent');
                }
              },
              child: const Text('Use passcode (mock)'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed('/consent'),
              child: const Text('Terms of Service / Confidentiality Agreement'),
            )
            ,
            const SizedBox(height: 8),
            // Developer helper: clear saved consent & signature
            TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('accepted_terms');
                await prefs.remove('signed_terms');
                await prefs.remove('signature_png_base64');
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Acceptance and signature cleared (dev)')));
                }
              },
              child: const Text('Reset Consent (dev)', style: TextStyle(color: Colors.redAccent)),
            )
          ],
        ),
      ),
    );
  }
}
