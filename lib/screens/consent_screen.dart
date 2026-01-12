import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signature_screen.dart';

class ConsentScreen extends StatefulWidget {
  const ConsentScreen({super.key});

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _scrolledToBottom = false;
  String _termsText = '';

  @override
  void initState() {
    super.initState();
    _loadTerms();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final max = _scrollController.position.maxScrollExtent;
    final pos = _scrollController.position.pixels;
    if (pos >= max - 16) {
      setState(() => _scrolledToBottom = true);
    }
  }

  Future<void> _loadTerms() async {
    // load from docs file if desired; for now include inline terms (keeps prototype self-contained)
    setState(() {
      _termsText = '''Spot-On Investigations: User Agreement & Privacy Policy
Last Updated: January 9, 2026

1. Acknowledgment of Invention & Ownership
By accessing this platform, the User acknowledges that the Lion’s Eye™ Intelligence Ecosystem and the Spot-On Investigations App are the sole intellectual property of Jerry AnTae Curry, Sr. (the "Inventor").

• Proprietary Rights: Users are granted a limited, non-transferable license to view case data. Any attempt to reverse-engineer, mirror, or redistribute the app’s architecture, reporting format, or metadata-hardening process is a violation of federal IP laws.
• Copyright: All content, including the Geometric Lion Logo and "Relentless Insight" branding, is protected under © 2026 Spot-On Investigations.

2. Confidentiality & Non-Disclosure (NDA)
The information contained within this portal is highly sensitive, legally privileged, and intended solely for the designated Client.

• User Responsibility: The User agrees to maintain the strict confidentiality of their login credentials.
• Third-Party Sharing: Sharing screenshots or raw data from the "Live Feed" with unauthorized third parties without the express written consent of Jerry AnTae Curry, Sr. may result in immediate termination of services and legal action.

3. Evidence Integrity & Metadata
• Admissibility: While Spot-On Investigations utilizes proprietary metadata-hardening (GPS, Timestamps, Hashing), the final determination of admissibility remains with the presiding court.
• No Alteration: The User agrees not to modify, crop, or strip metadata from files downloaded from the "Vault."

4. Security & Data Privacy
• Encryption: Spot-On Investigations utilizes SOC 2 compliant, end-to-end encryption.
• Data Retention: Evidence will be stored in the "Vault" for 90 days following the conclusion of the case, after which it will be archived or destroyed per jurisdictional legal requirements.

5. Limitation of Liability
Spot-On Investigations and its founder, Jerry AnTae Curry, Sr., provide intelligence based on available data and field observation. We do not guarantee specific legal outcomes. The User agrees to indemnify Spot-On Investigations against any claims arising from the User's misuse of the provided intelligence.

6. How To Execute
• Click-Wrap Agreement: The User must scroll to the bottom of this text before the "I Agree" button becomes active.
• Digital Signature: For high-stakes cases, the User can opt to sign digitally within the app.

Platform Architecture by Jerry AnTae Curry, Sr., MBA, PhD Candidate.
''';
    });
  }

  Future<void> _acceptTerms() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('accepted_terms', true);
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Agreement')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Text(_termsText, style: const TextStyle(height: 1.4)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pushNamed('/sign'),
                  child: const Text('Sign (optional)'),
                ),
                ElevatedButton(
                  onPressed: _scrolledToBottom ? _acceptTerms : null,
                  child: const Text('I Agree'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
