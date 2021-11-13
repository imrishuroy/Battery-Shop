import '/blocs/auth/auth_bloc.dart';

import '/repositories/auth/auth_repo.dart';
import '/repositories/battery/battery_repository.dart';
import '/repositories/firebase/firebase_repository.dart';
import '/repositories/firebase_services.dart';
import '/repositories/rest-apis/rest_apis_repo.dart';
import '/repositories/storage/storage_repo.dart';
import '/repositories/vehicles/vehicle_repository.dart';
import '/screens/home/bloc/app_actions_bloc.dart';
import '/screens/vehicle-brands/bloc/vehicle_brands_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/simple_bloc_observer.dart';
import 'config/auth_wrapper.dart';
import 'config/custom_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  EquatableConfig.stringify = kDebugMode;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider<FirebaseServices>(
          create: (_) => FirebaseServices(),
        ),
        RepositoryProvider<StorageRepository>(
          create: (_) => StorageRepository(),
        ),
        RepositoryProvider<FirebaseRepository>(
          create: (_) => FirebaseRepository(),
        ),
        RepositoryProvider<RestApisRepository>(
          create: (_) => RestApisRepository(),
        ),
        RepositoryProvider<BatteryRepository>(
          create: (_) => BatteryRepository(),
        ),
        RepositoryProvider<VehicleRepository>(
          create: (_) => VehicleRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<VehicleBrandsBloc>(
            create: (context) => VehicleBrandsBloc(
              firebaseServices: context.read<FirebaseServices>(),
            ),
          ),
          BlocProvider<AppActionsBloc>(
            create: (context) => AppActionsBloc(),
          )
        ],
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.redAccent.shade700,
            primarySwatch: Colors.red,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent.shade700,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: AuthWrapper.routeName,
          //home: ExcelScreen(),
          // home: BatteryScreen(),
        ),
      ),
    );
  }
}
