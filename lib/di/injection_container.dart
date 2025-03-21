import 'package:aksesin/data/datasource/auth_service.dart';
import 'package:aksesin/data/datasource/komunitas_firestore_service.dart';
import 'package:aksesin/data/datasource/notification_firestore_service.dart';
import 'package:aksesin/data/repositories/auth_repositoriy_impl.dart';
import 'package:aksesin/data/repositories/komunitas_repository_impl.dart';
import 'package:aksesin/domain/repositories/auth_repository.dart';
import 'package:aksesin/domain/repositories/komunitas_repository.dart';
import 'package:aksesin/domain/usecases/add_komunitas.dart';
import 'package:aksesin/domain/usecases/get_komunitas.dart';
import 'package:aksesin/domain/usecases/get_notification.dart';
import 'package:aksesin/domain/usecases/login_user.dart';
import 'package:aksesin/domain/usecases/register_user.dart';
import 'package:aksesin/presentation/provider/auth_provider.dart';
import 'package:aksesin/presentation/provider/komunitas_provider.dart';
import 'package:aksesin/presentation/provider/maps_provider.dart';
import 'package:aksesin/presentation/provider/notification_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:aksesin/data/models/user_model.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aksesin/domain/usecases/update_komunitas.dart';
import 'package:aksesin/data/repositories/user_tracking_repository_impl.dart';
import 'package:aksesin/domain/repositories/user_tracking_repository.dart';
import 'package:aksesin/domain/usecases/track_user.dart';
import 'package:aksesin/data/repositories/notification_repository_impl.dart';
import 'package:aksesin/domain/repositories/notification_repository.dart';
import 'package:aksesin/data/models/notification_model.dart';

final GetIt sl = GetIt.instance;

void setupDependencyInjection() {

  // Data Layer
  sl.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  sl.registerLazySingleton<KomunitasFirestoreService>(() => KomunitasFirestoreService());
  sl.registerLazySingleton<NotificationFirestoreService>(() => NotificationFirestoreService());

  // Repository Layer
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<KomunitasRepository>(() => KomunitasRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<UserTrackingRepository>(() => UserTrackingRepositoryImpl(sl()));
  sl.registerLazySingleton<NotificationRepository>(() => NotificationRepositoryImpl(sl()));

  // Use Cases
  sl.registerLazySingleton<LoginUser>(() => LoginUser(sl()));
  sl.registerLazySingleton<RegisterUser>(() => RegisterUser(sl()));
  sl.registerLazySingleton<AddKomunitas>(() => AddKomunitas(sl()));
  sl.registerLazySingleton<GetKomunitas>(() => GetKomunitas(sl()));
  sl.registerLazySingleton<UpdateKomunitas>(() => UpdateKomunitas(sl()));
  sl.registerLazySingleton<TrackUserById>(() => TrackUserById(sl()));
  sl.registerLazySingleton<GetNotification>(() => GetNotification(sl()));

  // Providers
  sl.registerLazySingleton<AuthProvider>(() => AuthProvider(
    loginUser: sl(),
    registerUser: sl(),
    authService: FirebaseAuthService()
   ));

   sl.registerLazySingleton<KomunitasProvider>(() => KomunitasProvider(
    addKomunitas: sl(),
    getKomunitas: sl(),
    updateKomunitas: sl(),
    getComments: sl(),
  ));

  sl.registerLazySingleton<MapsProvider>(() => MapsProvider());

  sl.registerLazySingleton<UserModel>(() => UserModel(
    id: '',
    username: '',
    email: '',
    disabilityOptions: [],
  ));

  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<NotificationProvider>(() => NotificationProvider(
    getNotification: sl(),
   ));
}