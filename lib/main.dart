import 'package:battery_shop/repository/services/firebase_service.dart';
import 'package:battery_shop/screens/home/home_screen.dart';
import 'package:battery_shop/screens/vehicle-brands/bloc/vehilce_brands_bloc.dart';
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
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.redAccent.shade700,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.redAccent.shade700,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<FirebaseService>(
            create: (_) => FirebaseService(),
          )
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider<VehilceBrandsBloc>(
            create: (context) => VehilceBrandsBloc(
              firebaseService: context.read<FirebaseService>(),
            ),
          )
        ], child: HomeScreen()),
      ),
    );
  }
}
