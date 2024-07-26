import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:mobileappfrontend/app.dart';
import 'package:mobileappfrontend/core/repositories/product/product_repository.dart';
import 'package:mobileappfrontend/core/repositories/product/product_repository_impl.dart';
import 'package:mobileappfrontend/core/repositories/product/product_repository_mock.dart';

final ValueNotifier<bool> connectivityNotifier = ValueNotifier(false);
final Logger _logger = Logger();

void main() async {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await setupLocatorAsync();

  await Future.delayed(const Duration(seconds: 3));
  runApp(const MyMaterialApp());
  FlutterNativeSplash.remove();
}

Future<void> setupLocatorAsync() async {
  GetIt.instance
      .registerLazySingleton<ProductRepository>(() => ProductRepositoryMock());
  await updateRepositoryBasedOnConnectivity();
  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    updateRepositoryBasedOnConnectivity();
  });
}

Future<void> updateRepositoryBasedOnConnectivity() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  _logger.w('Connectivity status:=== $connectivityResult');

  bool isConnected = connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi;

  if (isConnected != connectivityNotifier.value) {
    connectivityNotifier.value = isConnected;

    if (GetIt.instance.isRegistered<ProductRepository>()) {
      GetIt.instance.unregister<ProductRepository>();
    }

    GetIt.instance.registerLazySingleton<ProductRepository>(
        () => isConnected ? ProductRepositoryImpl() : ProductRepositoryMock());
  }

  _logger.w('_connectivityNotifier:=== ${connectivityNotifier.value}');
}
