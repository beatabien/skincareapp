import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skincareapp/app/pages/evening/cubit/evening_cubit.dart';

class EveningPage extends StatelessWidget {
  EveningPage({Key? key}) : super(key: key);

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EveningCubit()..start(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Wieczorna pielęgnacja',
          ),
          backgroundColor: const Color.fromARGB(255, 209, 167, 216),
        ),
        body: BlocBuilder<EveningCubit, EveningState>(
          builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return const Center(child: Text('Something went wrong'));
            }
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final documents = state.documents;
            return ListView(
              children: [
                for (final document in documents) ...[
                  Dismissible(
                      key: ValueKey(document.id),
                      onDismissed: (_) {
                        context
                            .read<EveningCubit>()
                            .delete(documentID: document.id);
                      },
                      child: EvenigPage(document['title'])),
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
                      hintText: 'Zaplnuj swoją wieczorną pielęgnację',
                    ),
                  ),
                )
              ],
            );
          },
        ),
        floatingActionButton: BlocBuilder<EveningCubit, EveningState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<EveningCubit>().add(controller.text);
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
