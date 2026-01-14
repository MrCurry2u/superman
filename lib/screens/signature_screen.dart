import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final SignatureController _controller = SignatureController(penStrokeWidth: 2, penColor: Colors.black);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveSignature() async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please sign first')));
      return;
    }
    final exported = await _controller.toPngBytes();
    if (exported == null) return;
    final base64Str = base64Encode(exported);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('signature_png_base64', base64Str);
    await prefs.setBool('signed_terms', true);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signature saved')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Agreement')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text('Please sign below using your finger or stylus.'),
            const SizedBox(height: 12),
            Expanded(
              child: Card(
                child: Signature(controller: _controller, backgroundColor: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () => _controller.clear(), child: const Text('Clear')),
                ElevatedButton(onPressed: _saveSignature, child: const Text('Save Signature')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
