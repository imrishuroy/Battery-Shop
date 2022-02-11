import '/constants/urls.dart';
import '/screens/price-list/widgets/battery_type_list.dart';
import 'package:flutter/material.dart';

// final List<String> batteryBrands = [
//   'EXIDE BATTERY',
//   'SKY BATTERY',
//   'AMARON BATTERY',
//   'LUMINIOUS BATTERY',
// ];

class BatteryList extends StatelessWidget {
  const BatteryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BatteryListTile(
          batteryBrand: 'EXIDE BATTERY',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const BatteryTypeScreen(
                  batteryBrand: 'EXIDE BATTERY',
                  batteryUrl: Urls.exideUrl,
                ),
              ),
            );
          },
        ),
        BatteryListTile(
          batteryBrand: 'SKY BATTERY',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const BatteryTypeScreen(
                  batteryBrand: 'SKY BATTERY',
                  batteryUrl: Urls.skyUrl,
                ),
              ),
            );
          },
        ),
        BatteryListTile(
          batteryBrand: 'AMARON BATTERY',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const BatteryTypeScreen(
                  batteryBrand: 'AMARON BATTERY',
                  batteryUrl: Urls.amaronUrl,
                ),
              ),
            );
          },
        ),
        BatteryListTile(
          batteryBrand: 'LUMINIOUS BATTERY',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const BatteryTypeScreen(
                  batteryBrand: 'LUMINIOUS BATTERY',
                  batteryUrl: Urls.amaronUrl,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class BatteryListTile extends StatelessWidget {
  final String batteryBrand;
  final VoidCallback onTap;

  const BatteryListTile(
      {Key? key, required this.batteryBrand, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          title: Text(
            batteryBrand,
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
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Divider(
            color: Colors.black45,
          ),
        )
      ],
    );
  }
}
