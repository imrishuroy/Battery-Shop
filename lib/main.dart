import '/config/custom_router.dart';
import '/repository/services/firebase_service.dart';
import '/screens/home/home_screen.dart';
import '/screens/vehicle-brands/bloc/vehilce_brands_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/simple_bloc_observer.dart';
import 'config/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  EquatableConfig.stringify = kDebugMode;
  await SharedPrefs().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseServices>(
          create: (_) => FirebaseServices(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<VehilceBrandsBloc>(
            create: (context) => VehilceBrandsBloc(
              firebaseService: context.read<FirebaseServices>(),
            ),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.redAccent.shade700, centerTitle: true),
            primaryColor: Colors.redAccent.shade700,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent.shade700,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: HomeScreen.routeName,
        ),
      ),
    );
  }
}
