import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/otp_screen.dart';
import '../screens/auth/set_password_screen.dart';
import '../screens/profile/edit_profile_screen.dart';
import '../screens/profile/profile_settings_screen.dart';
import '../screens/cart/my_cart_screen.dart';
import '../screens/cart/checkout_screen.dart';
import '../screens/cart/shipping_address_screen.dart';
import '../screens/cart/payment_method_screen.dart';
import '../screens/cart/add_card_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/product_detail_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/search/search_results_screen.dart';
import '../screens/search/filter_screen.dart';
import '../screens/orders/my_orders_screen.dart';
import '../screens/orders/track_order_screen.dart';
import '../screens/wallet/wallet_screen.dart';
import '../screens/main_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String setPassword = '/set-password';
  static const String editProfile = '/edit-profile';
  static const String profileSettings = '/profile-settings';
  static const String main = '/main';
  static const String home = '/home';
  static const String myCart = '/my-cart';
  static const String checkout = '/checkout';
  static const String shippingAddress = '/shipping-address';
  static const String paymentMethod = '/payment-method';
  static const String addCard = '/add-card';
  static const String productDetail = '/product-detail';
  static const String search = '/search';
  static const String searchResults = '/search-results';
  static const String filter = '/filter';
  static const String myOrders = '/my-orders';
  static const String trackOrder = '/track-order';
  static const String wallet = '/wallet';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashScreen(),
        login: (_) => const LoginScreen(),
        otp: (_) => const OtpScreen(),
        setPassword: (_) => const SetPasswordScreen(),
        editProfile: (_) => const EditProfileScreen(),
        profileSettings: (_) => const ProfileSettingsScreen(),
        main: (_) => const MainScreen(),
        myCart: (_) => const MyCartScreen(),
        checkout: (_) => const CheckoutScreen(),
        shippingAddress: (_) => const ShippingAddressScreen(),
        paymentMethod: (_) => const PaymentMethodScreen(),
        addCard: (_) => const AddCardScreen(),
        productDetail: (_) => const ProductDetailScreen(),
        search: (_) => const SearchScreen(),
        searchResults: (_) => const SearchResultsScreen(),
        filter: (_) => const FilterScreen(),
        myOrders: (_) => const MyOrdersScreen(),
        trackOrder: (_) => const TrackOrderScreen(),
        wallet: (_) => const WalletScreen(),
      };
}
