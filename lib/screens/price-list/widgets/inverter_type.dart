import 'package:battery_shop/screens/price-list/inverter_excel.dart';
import 'package:flutter/material.dart';

final List<String> _inverterTypeList = [
  'SQUARE WAVE',
  'SIN WAVE',
];

class InverterTypeScreen extends StatelessWidget {
  const InverterTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select your inverter'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: _inverterTypeList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => InverterExcel()));
                        },
                        title: Text(
                          _inverterTypeList[index],
                          style: TextStyle(fontSize: 17.0),
                        ),
                        trailing: SizedBox(
                          height: 50.0,
                          width: 90.0,
                          child: Image.asset(
                            'assets/inverter.png',
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
