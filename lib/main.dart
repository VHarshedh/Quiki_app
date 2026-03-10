import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'utils/app_theme.dart';
import 'utils/app_routes.dart';

// Core infrastructure
import 'core/infrastructure/network/firebase_auth_facade.dart';
import 'core/infrastructure/network/firebase_firestore_facade.dart';

// Auth
import 'auth/infrastructure/data_sources/auth_remote_data_source.dart';
import 'auth/infrastructure/repos/auth_repo.dart';
import 'auth/presentation/providers/auth_provider.dart';

// Features
import 'features/home/infrastructure/data_sources/products_remote_data_source.dart';
import 'features/home/infrastructure/repos/products_repo.dart';
import 'features/home/presentation/providers/products_provider.dart';

import 'features/cart/infrastructure/repos/cart_repo.dart';
import 'features/cart/presentation/providers/cart_provider.dart';

import 'features/orders/infrastructure/data_sources/orders_remote_data_source.dart';
import 'features/orders/infrastructure/repos/orders_repo.dart';
import 'features/orders/presentation/providers/orders_provider.dart';

import 'features/profile/infrastructure/repos/profile_repo.dart';
import 'features/profile/presentation/providers/profile_provider.dart';

import 'features/address/infrastructure/repos/address_repo.dart';
import 'features/address/presentation/providers/address_provider.dart';

import 'features/wallet/infrastructure/repos/wallet_repo.dart';
import 'features/wallet/presentation/providers/wallet_provider.dart';

import 'features/search/infrastructure/repos/search_repo.dart';
import 'features/search/presentation/providers/search_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const QuikiApp());
}

class QuikiApp extends StatelessWidget {
  const QuikiApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Shared facades
    final firebaseAuthFacade = FirebaseAuthFacade();
    final firebaseFirestoreFacade = FirebaseFirestoreFacade();

    // Auth layer
    final authRemoteDataSource = AuthRemoteDataSource(
      firebaseAuth: firebaseAuthFacade,
      firebaseFirestore: firebaseFirestoreFacade,
    );
    final authRepo = AuthRepo(remoteDataSource: authRemoteDataSource);

    // Products layer
    final productsRemoteDataSource = ProductsRemoteDataSource(
      firebaseFirestore: firebaseFirestoreFacade,
    );
    final productsRepo = ProductsRepo(remoteDataSource: productsRemoteDataSource);

    // Cart layer
    final cartRepo = CartRepo(firebaseFirestore: firebaseFirestoreFacade);

    // Orders layer
    final ordersRemoteDataSource = OrdersRemoteDataSource(
      firebaseFirestore: firebaseFirestoreFacade,
    );
    final ordersRepo = OrdersRepo(remoteDataSource: ordersRemoteDataSource);

    // Profile layer
    final profileRepo = ProfileRepo(firebaseFirestore: firebaseFirestoreFacade);

    // Address layer
    final addressRepo = AddressRepo(firebaseFirestore: firebaseFirestoreFacade);

    // Wallet layer
    final walletRepo = WalletRepo(firebaseFirestore: firebaseFirestoreFacade);

    // Search layer
    final searchRepo = SearchRepo(firebaseFirestore: firebaseFirestoreFacade);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authRepo: authRepo)),
        ChangeNotifierProvider(
            create: (_) => ProductsProvider(productsRepo: productsRepo)),
        ChangeNotifierProvider(create: (_) => CartProvider(cartRepo: cartRepo)),
        ChangeNotifierProvider(
            create: (_) => OrdersProvider(ordersRepo: ordersRepo)),
        ChangeNotifierProvider(
            create: (_) => ProfileProvider(profileRepo: profileRepo)),
        ChangeNotifierProvider(
            create: (_) => AddressProvider(addressRepo: addressRepo)),
        ChangeNotifierProvider(
            create: (_) => WalletProvider(walletRepo: walletRepo)),
        ChangeNotifierProvider(
            create: (_) => SearchProvider(searchRepo: searchRepo)),
      ],
      child: MaterialApp(
        title: 'Quiki',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
      ),
    );
  }
}
