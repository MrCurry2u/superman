import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms of Service')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('The Lions Eye — Terms of Service', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Text('Effective date: 2026-01-12'),
              SizedBox(height: 12),
              Text('1. Acceptance of Terms\n\nBy accessing or using The Lions Eye ("Service"), you agree to be bound by these Terms of Service ("Terms"). If you do not agree to these Terms, do not use the Service.'),
              SizedBox(height: 8),
              Text('2. Description of Service\n\nThe Service provides a secure client-facing investigative platform, including timeline feeds, secure storage (the Vault), and interactive evidence mapping. These features are provided for lawful investigative and protective use only.'),
              SizedBox(height: 8),
              Text('3. User Obligations and Compliance\n\nUsers must comply with all applicable laws and obtain any necessary consents before collecting or sharing personal data or location information. The Service may provide tools to collect biometric or location data; you are responsible for lawful use.'),
              SizedBox(height: 8),
              Text('4. Privacy and Data Handling\n\nData is transmitted over TLS and may be stored encrypted at rest. Biometric authentication uses device platform APIs; raw biometric templates are never stored by the Service. See our Privacy Policy for details.'),
              SizedBox(height: 8),
              Text('5. Intellectual Property\n\nAll content and software provided by The Lions Eye are the property of the provider and are protected by applicable intellectual property laws.'),
              SizedBox(height: 8),
              Text('6. Disclaimers and Limitations of Liability\n\nThe Service is provided "as is" without warranties of any kind. To the maximum extent permitted by law, the provider is not liable for damages arising from use of the Service.'),
              SizedBox(height: 8),
              Text('7. Governing Law\n\nThese Terms are governed by the laws of the jurisdiction in which the provider is incorporated, unless otherwise agreed.'),
              SizedBox(height: 12),
              Text('Contact: For legal inquiries, contact legal@thelions.eye'),
            ],
          ),
        ),
      ),
    );
  }
}
