import '/screens/price-list/battery_table.dart';
import 'package:flutter/material.dart';

// final List<String> _batteryTypeList = [
//   'Four wheeler batteries',
//   'Two wheeler batteries',
//   'Tabular batteries',
//   'Ups batteries',
// ];

class BatteryTypeScreen extends StatelessWidget {
  final String batteryBrand;
  final String batteryUrl;

  const BatteryTypeScreen({
    Key? key,
    required this.batteryBrand,
    required this.batteryUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select your vehicle'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            BatteryTypeTile(
              batteryBrand: batteryBrand,
              batteryType: 'Four wheeler batteries',
              batteryUrl: batteryUrl,
            ),
            BatteryTypeTile(
              batteryBrand: batteryBrand,
              batteryUrl: batteryUrl,
              batteryType: 'Two wheeler batteries',
            ),
            BatteryTypeTile(
              batteryBrand: batteryBrand,
              batteryUrl: batteryUrl,
              batteryType: 'Tabular batteries',
            ),
            BatteryTypeTile(
              batteryBrand: batteryBrand,
              batteryUrl: batteryUrl,
              batteryType: 'Ups batteries',
            ),
          ],
        ),
      ),
    );
  }
}

class BatteryTypeTile extends StatelessWidget {
  final String? batteryType;
  final String batteryBrand;
  final String batteryUrl;

  const BatteryTypeTile({
    Key? key,
    required this.batteryType,
    required this.batteryBrand,
    required this.batteryUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) =>
                    BatteryTable(url: batteryUrl, batteryBrand: batteryBrand),
              ),
            );
          },
          title: Text(
            batteryType ?? 'N/A',
            style: const TextStyle(fontSize: 17.0),
          ),
          trailing: SizedBox(
            height: 50.0,
            width: 90.0,
            child: Image.asset(
              'assets/battery.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Divider(),
        ),
      ],
    );
  }
}
