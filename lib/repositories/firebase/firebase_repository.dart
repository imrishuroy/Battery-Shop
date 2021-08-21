import 'package:admin_battery/constants/constants.dart';
import 'package:admin_battery/models/battery.dart';
import 'package:dio/dio.dart';

class FirebaseRepository {
  final _dio = Dio();

  Future<List<Battery?>> getAmaronBattery() async {
    List<Battery?> batteries = [];
    try {
      final response = await _dio.get(Urls.amaronUrl);
      // print(response.data);
      // print(response.statusCode);
      // print(response.data[0].runtimeType);

      if (response.statusCode == 200) {
        final List? data = response.data;
        data?.forEach((element) {
          final battery = Battery.fromMap(element);
          batteries.add(battery);
        });
      }
      return batteries;
    } catch (error) {
      print('Errro getting amaron battery');
      throw error;
    }
  }
}
