import 'package:battery_shop/screens/price-list/battery_excel.dart';
import 'package:flutter/material.dart';

final List<String> _batteryTypeList = [
  'Four wheeler batteries',
  'Two wheeler batteries',
  'Tabular batteries',
  'Ups batteries',
];

class BatteryTypeScreen extends StatelessWidget {
  const BatteryTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select your vehicle'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: _batteryTypeList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => BatteryExcel()));
                        },
                        title: Text(
                          _batteryTypeList[index],
                          style: TextStyle(fontSize: 17.0),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Divider(),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
