import '/config/shared_prefs.dart';

import '/screens/price-list/widgets/inverter_list.dart';
import 'package:flutter/material.dart';

import 'widgets/battery_list.dart';

class PriceListTab extends StatefulWidget {
  const PriceListTab({Key? key}) : super(key: key);

  @override
  State<PriceListTab> createState() => _PriceListTabState();
}

class _PriceListTabState extends State<PriceListTab> {
  String _dropdownValue = 'Battery Pricelist';

  @override
  void initState() {
    super.initState();
    _getPriceListValue();
  }

  Future<void> _getPriceListValue() async {
    try {
      setState(() {
        _dropdownValue = SharedPrefs().priceList;
      });
    } catch (error) {
      print('Error getting price list value ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          Center(
            child: DropdownButton<String>(
              value: _dropdownValue,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black, fontSize: 17.0),
              underline: Container(
                height: 2,
                color: Colors.redAccent.shade700,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _dropdownValue = newValue!;
                });
              },
              items: <String>['Battery Pricelist', 'Inverter Pricelist']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10.0),
          _dropdownValue == 'Battery Pricelist'
              ? const BatteryList()
              : const InverterList(),
        ],
      ),
    );
  }
}
