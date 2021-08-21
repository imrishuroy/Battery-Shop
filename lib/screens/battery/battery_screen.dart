import 'package:admin_battery/models/battery.dart';
import 'package:admin_battery/repositories/firebase/firebase_repository.dart';
import 'package:admin_battery/screens/battery/amaron_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BatteryScreen extends StatelessWidget {
  const BatteryScreen({Key? key}) : super(key: key);

  _getBattery(BuildContext context) async {
    final firebaseRepo = context.read<FirebaseRepository>();
    final result = await firebaseRepo.getAmaronBattery();
    print('Result  $result');
  }

  @override
  Widget build(BuildContext context) {
    final _firebaseRepo = context.read<FirebaseRepository>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _getBattery(context),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Amaron'),
      ),
      // body: TableExample(),

      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Battery?>>(
              future: _firebaseRepo.getAmaronBattery(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final amaron = snapshot.data;
                print('Amaron $amaron');
                if (amaron != null) {
                  return AmaronTable(
                    amaron: amaron,
                  );
                }
                return Center(
                  child: Text('Something went wrong'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
