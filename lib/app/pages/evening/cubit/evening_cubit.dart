import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'evening_state.dart';

class EveningCubit extends Cubit<EveningState> {
  EveningCubit()
      : super(
          const EveningState(
            documents: [],
            isLoading: false,
            errorMessage: '',
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> delete({required String documentID}) async {
    await FirebaseFirestore.instance
        .collection('evening')
        .doc(documentID)
        .delete();
  }

  Future<void> add(
    String title,
  ) async {
    await FirebaseFirestore.instance.collection('evening').add(
      {'title': title},
    );
  }

  Future<void> start() async {
    emit(const EveningState(
      documents: [],
      isLoading: true,
      errorMessage: '',
    ));

    _streamSubscription = FirebaseFirestore.instance
        .collection('evening')
        .orderBy('title')
        .snapshots()
        .listen((data) {
      emit(
        EveningState(
          documents: data.docs,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(EveningState(
            documents: const [],
            isLoading: false,
            errorMessage: error.toString()));
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
