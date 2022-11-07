import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skincareapp/app/pages/morning/cubit/morning_cubit.dart';

class MorningPage extends StatelessWidget {
  MorningPage({Key? key}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MorningCubit()..start(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Poranna pielęgnacja'),
          backgroundColor: const Color.fromARGB(255, 209, 167, 216),
        ),
        body: BlocBuilder<MorningCubit, MorningState>(
          builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return const Center(child: Text('Something went wrong'));
            }
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final documents = state.documents;
            return ListView(children: [
              for (final document in documents) ...[
                Dismissible(
                    key: ValueKey(document.id),
                    onDismissed: (_) {
                      context
                          .read<MorningCubit>()
                          .delete(documentID: document.id);
                    },
                    child: MorningWidget(document['title']))
              ],
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
                    hintText: 'Zaplnuj swoją poranną pielęgnację',
                  ),
                ),
              ),
            ]);
          },
        ),
        floatingActionButton: BlocBuilder<MorningCubit, MorningState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<MorningCubit>().add(controller.text);
                controller.clear();
              },
              backgroundColor: const Color.fromARGB(255, 209, 167, 216),
              child: const Icon(Icons.add),
            );
          },
        ),
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
