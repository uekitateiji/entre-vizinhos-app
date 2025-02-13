import 'package:flutter/material.dart';

class AdvertisePage extends StatelessWidget {
  const AdvertisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Anúncios", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
