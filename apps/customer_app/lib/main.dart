import 'package:flutter/material.dart';

void main() {
  runApp(const CustomerAppStub());
}

/// Placeholder entry point. No customer-facing screens exist yet — the
/// AI_INSTRUCTIONS Stitch mockups only cover the cook app so far, and
/// CLAUDE.md explicitly says not to freelance the customer UI ahead of
/// mockups being provided. This just keeps `customer_app` a valid Melos
/// workspace member.
class CustomerAppStub extends StatelessWidget {
  const CustomerAppStub({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Customer app — coming soon'),
        ),
      ),
    );
  }
}
