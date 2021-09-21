import '/models/battery.dart';
import '/models/inverter_wave.dart';
import '/repository/rest-apis/base_rest_api.repo.dart';
import 'package:dio/dio.dart';

class RestApisRepository extends BaseRestApiRepository {
  final _dio = Dio();

  Future<List<InverterWave?>> getWaveInverter(String url) async {
    final List<InverterWave?> inverters = [];
    try {
      final response = await _dio.get(url);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = response.data as List?;
        data?.forEach((element) {
          final item = element as Map<String, dynamic>;
          final battery = InverterWave.fromMap(item);
          inverters.add(battery);
        });
      }
      // print(batteries);
      return inverters;
    } catch (error) {
      print('Errro getting battery');
      rethrow;
    }
  }

  Future<List<Battery?>> getBatteries(String url) async {
    final List<Battery?> batteries = [];
    try {
      final response = await _dio.get(url);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final List? data = response.data as List?;
        data?.forEach((element) {
          final item = element as Map<String, dynamic>;
          final battery = Battery.fromMap(item);
          batteries.add(battery);
        });
      }
      // print(batteries);
      return batteries;
    } catch (error) {
      print('Errro getting battery');
      rethrow;
    }
  }
}
