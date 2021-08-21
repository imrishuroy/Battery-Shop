import 'package:admin_battery/blocs/auth/auth_bloc.dart';

import 'package:admin_battery/repositories/auth/auth_repo.dart';
import 'package:admin_battery/repositories/firebase/firebase_repository.dart';
import 'package:admin_battery/repositories/firebase_services.dart';
import 'package:admin_battery/repositories/storage/storage_repo.dart';
import 'package:admin_battery/screens/battery/battery_screen.dart';
import 'package:admin_battery/screens/excel/excel_screeen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.green),
          debugShowCheckedModeBanner: false,
          // onGenerateRoute: CustomRouter.onGenerateRoute,
          // initialRoute: AuthWrapper.routeName,
          //home: ExcelScreen(),
          home: BatteryScreen(),
        ),
      ),
    );
  }
}
