import '/constants/urls.dart';
import '/screens/price-list/inverter_excel.dart';
import 'package:flutter/material.dart';

class InverterTypeScreen extends StatelessWidget {
  const InverterTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select your inverter'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            InverterTypeTile(
              inverterType: 'SQUARE WAVE',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const InverterExcel(
                      url: Urls.squareWave,
                      inverterWave: 'Square Wave',
                    ),
                  ),
                );
              },
            ),
            InverterTypeTile(
              inverterType: 'SIN WAVE',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const InverterExcel(
                      url: Urls.sineWave,
                      inverterWave: 'Sine Wave',
                    ),
                  ),
                );
              },
            ),

            // Expanded(
            //   child: ListView.builder(
            //     itemCount: _inverterTypeList.length,
            //     itemBuilder: (context, index) {
            //       return Column(
            //         children: [
            //           InverterTypeTile(),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //             child: Divider(),
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class InverterTypeTile extends StatelessWidget {
  final String? inverterType;
  final VoidCallback onTap;

  const InverterTypeTile(
      {Key? key, required this.inverterType, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        inverterType ?? 'N/A',
        style: const TextStyle(fontSize: 17.0),
      ),
      trailing: SizedBox(
        height: 50.0,
        width: 90.0,
        child: Image.asset(
          'assets/inverter.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
