import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:orchid_vision/firebase_options.dart';
import 'package:orchid_vision/core/services/firebase/auth_service.dart';
import 'package:orchid_vision/core/services/firebase/firestore_service.dart';
import 'package:orchid_vision/core/services/firebase/storage_service.dart';
import 'package:orchid_vision/core/services/ai/tflite_service.dart';
import 'package:orchid_vision/core/services/ai/mobile_net_service.dart';
import 'package:orchid_vision/core/services/ai/yolo_service.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  serviceLocator.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  serviceLocator.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  serviceLocator.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);

  serviceLocator.registerLazySingleton<AuthService>(() => AuthService(serviceLocator<FirebaseAuth>()));
  serviceLocator.registerLazySingleton<FirestoreService>(() => FirestoreService(serviceLocator<FirebaseFirestore>()));
  serviceLocator.registerLazySingleton<StorageService>(() => StorageService(serviceLocator<FirebaseStorage>()));

  serviceLocator.registerLazySingleton<TFLiteService>(() => TFLiteService());
  serviceLocator.registerLazySingleton<MobileNetService>(() => MobileNetService());
  serviceLocator.registerLazySingleton<YoloService>(() => YoloService());
}
