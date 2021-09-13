import 'package:battery_shop/screens/price-list/widgets/battery_type_list.dart';
import 'package:flutter/material.dart';

final List<String> batteryBrands = [
  'EXIDE BATTERY',
  'SKY BATTERY',
  'AMARON BATTERY',
  'LUMINIOUS BATTERY',
];

class BatteryList extends StatelessWidget {
  const BatteryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: batteryBrands.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => BatteryTypeScreen()));
                },
                title: Text(
                  batteryBrands[index],
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Divider(
                  color: Colors.black45,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
