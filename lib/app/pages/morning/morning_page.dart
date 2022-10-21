import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MorningPage extends StatelessWidget {
  const MorningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poranna pielęgnacja'),
        backgroundColor: const Color.fromARGB(255, 209, 167, 216),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream:
                FirebaseFirestore.instance.collection('morning').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text('Loading'));
              }
              final documents = snapshot.data!.docs;
              return ListView(
                children: [MorningWidget(documents[0]['title'])],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 209, 167, 216),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MorningWidget extends StatelessWidget {
  const MorningWidget(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 155, 106, 164),
      padding: const EdgeInsets.all(20),
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
