import '../../../../core/infrastructure/network/firebase_firestore_facade.dart';

/// Wallet repository for balance and transactions from Firestore.
class WalletRepo {
  WalletRepo({required this.firebaseFirestore});

  final FirebaseFirestoreFacade firebaseFirestore;

  String _walletPath(String uid) => 'wallets/$uid';
  String _transactionsPath(String uid) => 'wallets/$uid/transactions';

  /// Get wallet balance.
  Future<Map<String, dynamic>?> getWallet(String uid) async {
    final doc = await firebaseFirestore.getData(path: _walletPath(uid));
    return doc.data();
  }

  /// Stream wallet balance (real-time).
  Stream<Map<String, dynamic>?> streamWallet(String uid) {
    return firebaseFirestore.streamDocument(path: _walletPath(uid)).map(
      (doc) => doc.data(),
    );
  }

  /// Stream transaction history (real-time).
  Stream<List<Map<String, dynamic>>> streamTransactions(String uid) {
    return firebaseFirestore
        .streamCollection(
      path: _transactionsPath(uid),
      queryBuilder: (ref) => ref.orderBy('date', descending: true),
    )
        .map(
      (snapshot) => snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList(),
    );
  }
}
