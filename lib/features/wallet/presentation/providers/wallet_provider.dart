import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../infrastructure/repos/wallet_repo.dart';

/// Wallet state provider using ChangeNotifier.
class WalletProvider extends ChangeNotifier {
  WalletProvider({required this.walletRepo});

  final WalletRepo walletRepo;

  double _balance = 0.0;
  List<Map<String, dynamic>> _transactions = [];
  bool _isLoading = false;
  String? _errorMessage;
  StreamSubscription<Map<String, dynamic>?>? _walletSub;
  StreamSubscription<List<Map<String, dynamic>>>? _transactionsSub;
  String? _currentUid;

  double get balance => _balance;
  List<Map<String, dynamic>> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Start listening to wallet data for a user.
  void listenToWallet(String uid) {
    if (_currentUid == uid) return;
    _currentUid = uid;
    _walletSub?.cancel();
    _transactionsSub?.cancel();
    _isLoading = true;
    notifyListeners();

    _walletSub = walletRepo.streamWallet(uid).listen(
      (data) {
        _balance = (data?['balance'] as num?)?.toDouble() ?? 0.0;
        _isLoading = false;
        notifyListeners();
      },
      onError: (e) {
        _errorMessage = e.toString();
        _isLoading = false;
        notifyListeners();
      },
    );

    _transactionsSub = walletRepo.streamTransactions(uid).listen(
      (transactions) {
        _transactions = transactions;
        notifyListeners();
      },
      onError: (e) {
        _errorMessage = e.toString();
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _walletSub?.cancel();
    _transactionsSub?.cancel();
    super.dispose();
  }
}
