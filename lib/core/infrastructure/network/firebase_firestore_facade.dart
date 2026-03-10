import 'package:cloud_firestore/cloud_firestore.dart';

/// Thin wrapper around [FirebaseFirestore] for testability and consistency.
/// All data sources should use this instead of calling Firestore directly.
class FirebaseFirestoreFacade {
  FirebaseFirestoreFacade({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  /// Get a single document by path (e.g. 'users/abc123').
  Future<DocumentSnapshot<Map<String, dynamic>>> getData({
    required String path,
  }) {
    return _firestore.doc(path).get();
  }

  /// Set (create/overwrite) a document at the given path.
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) {
    return _firestore.doc(path).set(data, SetOptions(merge: merge));
  }

  /// Update specific fields of a document.
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) {
    return _firestore.doc(path).update(data);
  }

  /// Delete a document at the given path.
  Future<void> deleteData({required String path}) {
    return _firestore.doc(path).delete();
  }

  /// Add a document to a collection (auto-generated ID).
  Future<DocumentReference<Map<String, dynamic>>> addData({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) {
    return _firestore.collection(collectionPath).add(data);
  }

  /// Get all documents in a collection.
  Future<QuerySnapshot<Map<String, dynamic>>> getCollectionData({
    required String path,
    Query<Map<String, dynamic>> Function(CollectionReference<Map<String, dynamic>>)?
        queryBuilder,
  }) {
    Query<Map<String, dynamic>> query = _firestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(_firestore.collection(path));
    }
    return query.get();
  }

  /// Stream all documents in a collection (real-time).
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCollection({
    required String path,
    Query<Map<String, dynamic>> Function(CollectionReference<Map<String, dynamic>>)?
        queryBuilder,
  }) {
    Query<Map<String, dynamic>> query = _firestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(_firestore.collection(path));
    }
    return query.snapshots();
  }

  /// Stream a single document (real-time).
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamDocument({
    required String path,
  }) {
    return _firestore.doc(path).snapshots();
  }
}
