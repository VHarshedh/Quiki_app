import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/address.dart';
import '../../infrastructure/repos/address_repo.dart';

/// Address state provider using ChangeNotifier.
class AddressProvider extends ChangeNotifier {
  AddressProvider({required this.addressRepo});

  final AddressRepo addressRepo;

  List<Address> _addresses = [];
  Address? _selectedAddress;
  bool _isLoading = false;
  String? _errorMessage;
  StreamSubscription<List<Map<String, dynamic>>>? _subscription;
  String? _currentUid;

  List<Address> get addresses => _addresses;
  Address? get selectedAddress => _selectedAddress ?? defaultAddress;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Address? get defaultAddress {
    try {
      return _addresses.firstWhere((a) => a.isDefault);
    } catch (_) {
      return _addresses.isNotEmpty ? _addresses.first : null;
    }
  }

  /// Start listening to addresses for a user.
  void listenToAddresses(String uid) {
    if (_currentUid == uid) return;
    _currentUid = uid;
    _subscription?.cancel();
    _isLoading = true;
    notifyListeners();

    _subscription = addressRepo.streamAddresses(uid).listen(
      (data) {
        _addresses = data
            .map((d) => Address(
                  id: d['id'] ?? '',
                  label: d['label'] ?? 'Home',
                  street: d['street'] ?? '',
                  city: d['city'] ?? '',
                  state: d['state'] ?? '',
                  zipCode: d['zipCode'] ?? '',
                  isDefault: d['isDefault'] ?? false,
                ))
            .toList();
        _isLoading = false;
        notifyListeners();
      },
      onError: (e) {
        _errorMessage = e.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  /// Select an address for checkout.
  void selectAddress(Address address) {
    _selectedAddress = address;
    notifyListeners();
  }

  /// Add a new address.
  Future<void> addAddress(String uid, Map<String, dynamic> data) async {
    try {
      await addressRepo.addAddress(uid, data);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Update an existing address.
  Future<void> updateAddress(
      String uid, String id, Map<String, dynamic> data) async {
    try {
      await addressRepo.updateAddress(uid, id, data);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Delete an address.
  Future<void> deleteAddress(String uid, String id) async {
    try {
      await addressRepo.deleteAddress(uid, id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
