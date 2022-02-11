import '/screens/price-list/widgets/inverter_type.dart';
import 'package:flutter/material.dart';

final List<String> inverterBrands = [
  'EXIDE INVERTER',
  'SKY INVERTER',
  'AMARON INVERTER',
  'LUMINOUS INVERTER',
];

class InverterList extends StatelessWidget {
  const InverterList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: inverterBrands.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const InverterTypeScreen()));
                },
                title: Text(
                  inverterBrands[index],
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
