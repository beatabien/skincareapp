import 'package:flutter/material.dart';

class CarePage extends StatelessWidget {
  const CarePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SkinCare'),
        backgroundColor: const Color.fromARGB(255, 209, 167, 216),
      ),
    );
  }
}
