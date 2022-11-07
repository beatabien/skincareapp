import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EveningPage extends StatelessWidget {
  EveningPage({Key? key}) : super(key: key);

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wieczorna pielęgnacja',
        ),
        backgroundColor: const Color.fromARGB(255, 209, 167, 216),
      ),
      body: ListView(
        children: [
          const EvenigPage(''),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
                hintText: 'Zaplnuj swoją wieczorną pielęgnację',
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 209, 167, 216),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class EvenigPage extends StatelessWidget {
  const EvenigPage(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 155, 106, 164),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      child: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
