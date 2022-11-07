part of 'evening_cubit.dart';

@immutable
class EveningState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;
  final String errorMessage;

  const EveningState(
      {required this.documents,
      required this.isLoading,
      required this.errorMessage});
}
