import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MorningPage extends StatelessWidget {
  MorningPage({Key? key}) : super(key: key);

  final conttoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poranna pielęgnacja'),
        backgroundColor: const Color.fromARGB(255, 209, 167, 216),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('morning')
                .orderBy('title')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text('Loading'));
              }
              final documents = snapshot.data!.docs;
              return ListView(children: [
                for (final document in documents) ...[
                  Dismissible(
                      key: ValueKey(document.id),
                      onDismissed: (_) {
                        FirebaseFirestore.instance
                            .collection('morning')
                            .doc(document.id)
                            .delete();
                      },
                      child: MorningWidget(document['title']))
                ],
                const SizedBox(height: 20),
                TextField(
                  controller: conttoller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    hintText: 'Zaplnuj swoją poranną pielęgnację',
                  ),
                ),
              ]);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('morning').add(
            {'title': conttoller.text},
          );
          conttoller.clear();
        },
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
