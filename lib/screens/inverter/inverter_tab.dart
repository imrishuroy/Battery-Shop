import 'package:battery_shop/config/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _klabelStyle = TextStyle(fontSize: 16.0, letterSpacing: 1.2);

const _kValueStyle =
    TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, letterSpacing: 1.2);

class InveterTab extends StatefulWidget {
  final TabController? tabController;

  const InveterTab({Key? key, required this.tabController}) : super(key: key);

  @override
  _InveterTabState createState() => _InveterTabState();
}

class _InveterTabState extends State<InveterTab> {
  // var _load = ['20', '50', '70', '100'];

  // String? _currentSelectedValue = '50';
  bool isFanTileExpaned = false;
  bool isTvTileExpanded = false;
  bool isPcTIleExpaned = false;
  bool isMotoTileExpanded = false;

  void _displayDialog({
    required int? load,
    required int? ah,
    required int? noOfBattery,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Recomendation for your perfect inverter battery',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Battery',
                    style: _klabelStyle,
                  ),
                  Text(
                    // '100AH',
                    '${ah ?? 'N/A'} AH',
                    style: _kValueStyle,
                  ),
                ],
              ),
              const SizedBox(height: 3.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Inverter',
                    style: _klabelStyle,
                  ),
                  Text(
                    //'650AV',
                    '${load ?? 'N/A'}' + 'AV',
                    style: _kValueStyle,
                  ),
                ],
              ),
              const SizedBox(height: 3.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'No Of Battery',
                    style: _klabelStyle,
                  ),
                  const SizedBox(width: 17.0),
                  Text(
                    '${noOfBattery ?? 'N/A'}',
                    style: _kValueStyle,
                  ),
                  const SizedBox(height: 3.0),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () async {
                      await SharedPrefs().setPriceList('Inverter Pricelist');
                      Navigator.of(context).pop();
                      //DefaultTabController.of(context)?.animateTo(3);
                      widget.tabController?.animateTo(2);
                    },
                    child: Text('Buy Inverter'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () async {
                      await SharedPrefs().setPriceList('Battery Pricelist');
                      Navigator.of(context).pop();

                      widget.tabController?.animateTo(2);
                    },
                    child: Text('Buy Battery'),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.redAccent.shade700,
                    textStyle: TextStyle(fontSize: 17.0)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Re calculate'),
              )
            ],
          ),
        );
      },
    );
  }

  String? _loadInWatt = '0';
  String? _backupInHour = '0';

  final _formKey = GlobalKey<FormState>();

  final _loadController = TextEditingController();
  final _hourController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadController.text = '0';
    _hourController.text = '0';
  }

  void _calculateInverter() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_loadInWatt != null && _backupInHour != null) {
        double? load = double.tryParse(_loadInWatt!);
        double? _backup = double.tryParse(_backupInHour!);
        if (load != null && _backup != null) {
          double initialLoad = int.parse(_loadController.text) / 0.8;
          double initialAH = initialLoad * _backup / 12;
          int totalAH = (initialAH * 0.35).ceil();
          print('Total Ah $totalAH');

          double twentyFivePer = initialLoad * 0.25;
          double total = initialLoad + twentyFivePer;
          print('Total ${total.ceil()}');
          print('Total ${total.runtimeType}');

          if (totalAH > 220) {
            _displayDialog(load: total.ceil(), noOfBattery: 2, ah: totalAH);
            // _displayDialog(
            //     load: 1500, ah: (totalAH / 2).ceil(), noOfBattery: 2);
          } else {
            _displayDialog(load: total.ceil(), noOfBattery: 1, ah: totalAH);
          }
        }
      }
    }
  }

  // bool _check = false;
  // String? _changingValue;

  void _increaseWatt(int value) {
    setState(() {
      _loadController.text =
          (int.parse(_loadController.text) + value).toString();
      // _totalWatt = _totalWatt + value;
    });
  }

  void _decreaseWatt(int value) {
    setState(() {
      print('LoadController text -  ${_loadController.text}');
      if (int.tryParse(_loadController.text)! > 0) {
        int? loadValue = int.tryParse(_loadController.text);

        if (loadValue != null && loadValue >= value) {
          _loadController.text = (loadValue - value).toString();
        }

        // _loadController.text =
        //     (int.parse(_loadController.text) - value).toString() ?? ;
        //_totalWatt = _totalWatt - value;
      }
      // if (_loadController.text == null) {
      //   _loadController.text = '0';
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20.0),
                Text(
                  'Inverter & Battery Calculator',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 18.0,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                        ],
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                        validator: (value) {
                          print('Value $value');
                          print('Runtime type ${value.runtimeType}');
                          if (value!.isEmpty) {
                            return 'Load can\'t be empty';
                          } else if (value == '0') {
                            return 'Load can\'t be 0';
                          }
                        },
                        controller: _loadController,
                        onSaved: (value) => _loadInWatt = value,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter load ( In Watt )',
                          labelText: 'Load ( In Watt )',
                          labelStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 10.0),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [Text('Total Watt $_totalWatt')],
                      // ),
                      const SizedBox(height: 25.0),
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please add your backup hours';
                          } else if (value == '0') {
                            return 'Backup can\'t be 0';
                          }
                        },
                        onSaved: (value) => _backupInHour = value,
                        controller: _hourController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Backup Required ( In Hours )',
                          labelText: 'Backup Required ( In Hours )',
                          labelStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                      //TextFormField(),
                      // const SizedBox(height: 25.0),
                      // FormField<String>(
                      //   builder: (FormFieldState<String> state) {
                      //     return InputDecorator(
                      //       decoration: InputDecoration(
                      //           //labelStyle: textStyle,
                      //           errorStyle: TextStyle(
                      //               color: Colors.redAccent, fontSize: 16.0),
                      //           hintText: 'Please select expense',
                      //           border: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(5.0))),
                      //       isEmpty: _currentSelectedValue == '',
                      //       child: DropdownButtonHideUnderline(
                      //         child: DropdownButton<String>(
                      //           value: _currentSelectedValue,
                      //           isDense: true,
                      //           onChanged: (value) {
                      //             setState(() {
                      //               _currentSelectedValue = value;
                      //             });
                      //           },
                      //           items: _load.map((String value) {
                      //             return DropdownMenuItem<String>(
                      //               value: value,
                      //               child: Text(value),
                      //             );
                      //           }).toList(),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                      const SizedBox(height: 10.0),
                      ExpansionTile(
                        onExpansionChanged: (value) {
                          print(value);
                          setState(() {
                            isTvTileExpanded = value;
                          });
                        },
                        title: Text('Fan & Cooler'),
                        leading: isTvTileExpanded
                            ? Icon(Icons.remove_circle_outline_outlined)
                            : Icon(Icons.add_circle_outline_rounded),
                        trailing: SizedBox.shrink(),
                        children: [
                          WattAndQty(),
                          const SizedBox(height: 10.0),
                          ExpansionItem(
                            label: 'Fan',
                            watt: 20,
                            onPressIncrease: () {
                              _increaseWatt(20);
                            },
                            onPressDecrease: () {
                              _decreaseWatt(20);
                            },
                          ),
                          const SizedBox(height: 10.0),
                          ExpansionItem(
                            label: 'Cooler',
                            watt: 30,
                            onPressIncrease: () {
                              _increaseWatt(30);
                            },
                            onPressDecrease: () {
                              _decreaseWatt(30);
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      ExpansionTile(
                        onExpansionChanged: (value) {
                          print(value);
                          setState(() {
                            isFanTileExpaned = value;
                          });
                        },
                        title: Text('TV & Other'),
                        leading: isFanTileExpaned
                            ? Icon(Icons.remove_circle_outline_outlined)
                            : Icon(Icons.add_circle_outline_rounded),
                        trailing: SizedBox.shrink(),
                        children: [
                          WattAndQty(),
                          const SizedBox(height: 10.0),
                          ExpansionItem(
                            label: 'Television (LED)',
                            watt: 60,
                            onPressIncrease: () {
                              _increaseWatt(60);
                            },
                            onPressDecrease: () {
                              _decreaseWatt(60);
                            },
                          ),
                          const SizedBox(height: 10.0),
                          ExpansionItem(
                            label: 'Set Up Box',
                            watt: 50,
                            onPressIncrease: () {
                              _increaseWatt(50);
                            },
                            onPressDecrease: () {
                              _decreaseWatt(50);
                            },
                          ),
                          const SizedBox(height: 10.0),
                          ExpansionItem(
                            label: 'Music System',
                            watt: 300,
                            onPressIncrease: () {
                              _increaseWatt(300);
                            },
                            onPressDecrease: () {
                              _decreaseWatt(300);
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      ExpansionTile(
                        onExpansionChanged: (value) {
                          print(value);
                          setState(() {
                            isPcTIleExpaned = value;
                          });
                        },
                        title: Text('PC & Other'),
                        leading: isPcTIleExpaned
                            ? Icon(Icons.remove_circle_outline_outlined)
                            : Icon(Icons.add_circle_outline_rounded),
                        trailing: SizedBox.shrink(),
                        children: [
                          WattAndQty(),
                          const SizedBox(height: 10.0),
                          ExpansionItem(
                            label: 'Laptop',
                            watt: 100,
                            onPressIncrease: () {
                              _increaseWatt(100);
                            },
                            onPressDecrease: () {
                              _decreaseWatt(100);
                            },
                          ),
                          const SizedBox(height: 10.0),
                          ExpansionItem(
                            label: 'Desktop Computer',
                            watt: 200,
                            onPressIncrease: () {
                              _increaseWatt(200);
                            },
                            onPressDecrease: () {
                              _decreaseWatt(200);
                            },
                          ),
                          const SizedBox(height: 10.0),
                          ExpansionItem(
                            label: 'Printer',
                            watt: 200,
                            onPressIncrease: () {
                              _increaseWatt(200);
                            },
                            onPressDecrease: () {
                              _decreaseWatt(200);
                            },
                          )
                        ],
                      ),

                      const SizedBox(height: 10.0),
                      ExpansionTile(
                        onExpansionChanged: (value) {
                          print(value);
                          setState(() {
                            isMotoTileExpanded = value;
                          });
                        },
                        title: Text('Motor'),
                        leading: isMotoTileExpanded
                            ? Icon(Icons.remove_circle_outline_outlined)
                            : Icon(Icons.add_circle_outline_rounded),
                        trailing: SizedBox.shrink(),
                        children: [
                          WattAndQty(),
                          const SizedBox(height: 10.0),
                          ExpansionItem(
                            label: 'Water Pump (0.5 HP)',
                            watt: 400,
                            onPressIncrease: () {
                              _increaseWatt(400);
                            },
                            onPressDecrease: () {
                              _decreaseWatt(400);
                            },
                          ),
                          const SizedBox(height: 10.0),
                          ExpansionItem(
                            label: 'Water Pump (1 HP)',
                            watt: 800,
                            onPressIncrease: () {
                              _increaseWatt(800);
                            },
                            onPressDecrease: () {
                              _decreaseWatt(800);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 35.0),

                      SizedBox(
                        height: 40.0,
                        width: 160.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          onPressed: _calculateInverter,
                          //   onPressed: _calculate,
                          child: Text('Calculate'),
                        ),
                      ),
                      const SizedBox(height: 50.0),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WattAndQty extends StatelessWidget {
  const WattAndQty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Text(
          'Watt',
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
        SizedBox(width: 39.0),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text(
            'Qty',
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
        ),
        SizedBox(width: 39.0),
      ],
    );
  }
}

class ExpansionItem extends StatefulWidget {
  final String? label;
  final int? watt;
  final Function onPressIncrease;
  final Function onPressDecrease;

  const ExpansionItem({
    Key? key,
    required this.label,
    required this.watt,
    required this.onPressIncrease,
    required this.onPressDecrease,
  }) : super(key: key);

  @override
  _ExpansionItemState createState() => _ExpansionItemState();
}

class _ExpansionItemState extends State<ExpansionItem> {
  int value = 0;

  // _increaseDecrease() {
  //   widget.onPressed();
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 100.0,
          child: Text(
            '${widget.label}',
            style: TextStyle(
              fontSize: 16.5,
              //fontWeight: FontWeight.w500,
            ),
            //textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 70.0),

        Text(
          '${widget.watt}',
          style: TextStyle(
            fontSize: 17.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        //   const SizedBox(width: 1.0),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  value++;
                  widget.onPressIncrease();
                });
              },
              icon: Icon(
                Icons.add_circle_outline_rounded,
                color: Colors.green,
              ),
            ),
            Text(
              '$value',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            IconButton(
              onPressed: value > 0
                  ? () {
                      setState(() {
                        if (value > 0) {
                          value--;
                          widget.onPressDecrease();
                        }
                      });
                    }
                  : null,
              icon: Icon(
                Icons.remove_circle_outline_outlined,
                color: Colors.red,
              ),
            ),
          ],
        )
      ],
    );
  }
}
