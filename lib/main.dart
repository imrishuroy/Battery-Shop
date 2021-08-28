import 'package:admin_battery/blocs/auth/auth_bloc.dart';

import 'package:admin_battery/repositories/auth/auth_repo.dart';
import 'package:admin_battery/repositories/battery/battery_repository.dart';
import 'package:admin_battery/repositories/firebase/firebase_repository.dart';
import 'package:admin_battery/repositories/firebase_services.dart';
import 'package:admin_battery/repositories/rest-apis/rest_apis_repo.dart';
import 'package:admin_battery/repositories/storage/storage_repo.dart';
import 'package:admin_battery/screens/amaron/bloc/amaron_bloc.dart';
import 'package:admin_battery/screens/exide/bloc/exide_bloc.dart';
import 'package:admin_battery/screens/sky/bloc/sky_bloc.dart';
import 'package:admin_battery/screens/vehicle-brands/bloc/vehicle_brands_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/auth_wrapper.dart';
import 'config/custom_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        RepositoryProvider(
          create: (_) => BatteryRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          // BlocProvider<AmaronBloc>(
          //   create: (context) => AmaronBloc(
          //     restApisRepository: context.read<RestApisRepository>(),
          //   ),
          // ),
          // BlocProvider<SkyBloc>(
          //   create: (context) => SkyBloc(
          //     restApisRepository: context.read<RestApisRepository>(),
          //   ),
          // ),
          // BlocProvider<ExideBloc>(
          //   create: (context) => ExideBloc(
          //     restApisRepository: context.read<RestApisRepository>(),
          //   ),
          // ),
          BlocProvider<VehicleBrandsBloc>(
            create: (context) => VehicleBrandsBloc(
              firebaseServices: context.read<FirebaseServices>(),
            ),
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
