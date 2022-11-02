import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'morning_state.dart';

class MorningCubit extends Cubit<MorningState> {
  MorningCubit()
      : super(const MorningState(
          documents: [],
          isLoading: false,
          errorMessage: '',
        ));

  StreamSubscription? _streamSubscription;

  Future<void> delete({required String documentID}) async {
    await FirebaseFirestore.instance
        .collection('morning')
        .doc(documentID)
        .delete();
  }

  Future<void> add(
    String title,
  ) async {
    await FirebaseFirestore.instance.collection('morning').add(
      {'title': title},
    );
  }

  Future<void> start() async {
    emit(const MorningState(
      documents: [],
      isLoading: true,
      errorMessage: '',
    ));

    _streamSubscription = FirebaseFirestore.instance
        .collection('morning')
        .orderBy('title')
        .snapshots()
        .listen((data) {
      emit(
        MorningState(
          documents: data.docs,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(MorningState(
            documents: const [], isLoading: false, errorMessage: error.toString()));
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
