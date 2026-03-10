import '../../../../core/infrastructure/network/firebase_firestore_facade.dart';

/// Address repository for CRUD on users/{uid}/addresses subcollection.
class AddressRepo {
  AddressRepo({required this.firebaseFirestore});

  final FirebaseFirestoreFacade firebaseFirestore;

  String _addressesPath(String uid) => 'users/$uid/addresses';
  String _addressDocPath(String uid, String id) => 'users/$uid/addresses/$id';

  /// Stream all addresses for a user.
  Stream<List<Map<String, dynamic>>> streamAddresses(String uid) {
    return firebaseFirestore.streamCollection(path: _addressesPath(uid)).map(
      (snapshot) => snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList(),
    );
  }

  /// Add a new address.
  Future<void> addAddress(String uid, Map<String, dynamic> data) async {
    await firebaseFirestore.addData(
      collectionPath: _addressesPath(uid),
      data: data,
    );
  }

  /// Update an existing address.
  Future<void> updateAddress(
      String uid, String id, Map<String, dynamic> data) async {
    await firebaseFirestore.updateData(
      path: _addressDocPath(uid, id),
      data: data,
    );
  }

  /// Delete an address.
  Future<void> deleteAddress(String uid, String id) async {
    await firebaseFirestore.deleteData(path: _addressDocPath(uid, id));
  }
}
