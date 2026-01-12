import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/consent_screen.dart';
import 'screens/signature_screen.dart';
import 'screens/case_overview.dart';

void main() {
  runApp(const TheLionsEyeApp());
}

class TheLionsEyeApp extends StatelessWidget {
  const TheLionsEyeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Lions Eye — Prototype',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const Startup(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/case': (context) => const CaseOverviewScreen(),
        '/consent': (context) => const ConsentScreen(),
        '/sign': (context) => const SignatureScreen(),
      },
    );
  }
}

class Startup extends StatefulWidget {
  const Startup({super.key});

  @override
  State<Startup> createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  @override
  void initState() {
    super.initState();
    _checkConsent();
  }

  Future<void> _checkConsent() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accepted = prefs.getBool('accepted_terms') ?? false;
      if (!mounted) return;
      if (accepted) Navigator.of(context).pushReplacementNamed('/login');
      else Navigator.of(context).pushReplacementNamed('/consent');
    } catch (_) {
      if (mounted) Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
