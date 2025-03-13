import 'package:aksesin/data/datasource/auth_service.dart';
import 'package:aksesin/data/repositories/auth_repositoriy_impl.dart';
import 'package:aksesin/domain/repositories/auth_repository.dart';
import 'package:aksesin/domain/usecases/login_user.dart';
import 'package:aksesin/domain/usecases/register_user.dart';
import 'package:aksesin/presentation/provider/auth_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:aksesin/data/models/user_model.dart'; 

final sl = GetIt.instance;

void setupDependencyInjection() {

  // Data Layer
  sl.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());

  // Repository Layer
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Use Cases
  sl.registerLazySingleton<LoginUser>(() => LoginUser(sl()));
  sl.registerLazySingleton<RegisterUser>(() => RegisterUser(sl()));

  // Providers
  sl.registerLazySingleton<AuthProvider>(() => AuthProvider(
    loginUser: sl(),
    registerUser: sl(),
    authService: FirebaseAuthService()
   ));

  // Add this block
  sl.registerLazySingleton<UserModel>(() => UserModel(
    id: '',
    username: '',
    email: '',
    disabilityOptions: [],
  ));
}