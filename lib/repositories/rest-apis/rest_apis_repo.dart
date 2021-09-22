import '/models/battery.dart';
import 'package:dio/dio.dart';

class RestApisRepository {
  final _dio = Dio();

  Future<List<Battery?>> getBatteries(String url) async {
    List<Battery?> batteries = [];
    try {
      final response = await _dio.get(url);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final List? data = response.data;
        data?.forEach((element) {
          final battery = Battery.fromMap(element);
          batteries.add(battery);
        });
      }
      // print(batteries);
      return batteries;
    } catch (error) {
      print('Errro getting battery');
      throw error;
    }
  }
}
