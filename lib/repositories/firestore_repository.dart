import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository<T> {
  FirestoreRepository({required this.fromDS});

  final T Function(Map<String, dynamic> data, String documentId) fromDS;

  Future<List<T>> collectionData({
    required String path,
  }) async {
    final reference = FirebaseFirestore.instance.collection(path);
    final querySnapshot = await reference.get();
    return querySnapshot.docs
        .map(
          (doc) => fromDS(doc.data(), doc.id),
        )
        .toList();
  }
}
