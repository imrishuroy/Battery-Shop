import 'package:battery_shop/screens/home/widgets/drop_down_tile.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String dropdownValue = 'One';

  List<String> brands = [
    'BMW',
    'CHEVROLET',
    'FIAT',
    'FORD',
    'HONDA',
    'HYUNDAI',
    'KIA',
    'MAHINDRA',
    'MARUTI',
    'MERCEDES-BENZ',
    'NISSAN',
    'RENAULT',
    'SKODA',
    'TATA',
    'TOYOTA',
    'VW',
    'ASHOK LEYLAND',
    'AUDI',
    'BENTLEY',
    'BUGATTI'
  ];

  List<String> _models = [
    'Model 1',
    'Model 2',
    'Model 3',
    'Model 4',
    'Model 5',
    'Model 6'
  ];

  String? _selectedBrand;
  String? _selectedModel;

  void _onSelectBrand(String value) {
    setState(() {
      _selectedBrand = value;
    });
    Navigator.of(context).pop();
    _showBrandBottomSheet(context);
    print('Selected Value $_selectedBrand');
  }

  void _onSelectModel(String value) {
    setState(() {
      _selectedModel = value;
    });
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    _showBrandBottomSheet(context);
    //_showBrand(context);
    print('Selected Value $_selectedModel');
  }

  void _showModelDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 22.0,
            vertical: 25.0,
          ),
          content: Container(
            alignment: Alignment.topLeft,
            height: 200.0,
            //color: Colors.red,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var item in _models)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 7.0,
                        bottom: 7.0,
                      ),
                      child: InkWell(
                        onTap: () => _onSelectModel(item),
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            item,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBrandDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 22.0,
            vertical: 25.0,
          ),
          content: Container(
            alignment: Alignment.topLeft,
            height: 300.0,
            //color: Colors.red,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var item in brands)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 7.0,
                        bottom: 7.0,
                      ),
                      child: InkWell(
                        onTap: () => _onSelectBrand(item),
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            item,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBrandBottomSheet(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 320.0,
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        // color: Colors.red,
        // width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search your vehicles',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                )
              ],
            ),
            const SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: Colors.grey.shade600),
                ),
                child: Center(
                  child: Text(
                    '${_selectedBrand ?? ''}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            DropDownTile(
                label: _selectedModel ?? 'Your model',
                onPressed: () => _showModelDialog()),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _selectedBrand = null;
                      _selectedBrand = null;
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 50.0,
                        width: 50.0,
                        child: Image.asset(
                          'assets/petrol.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 3.8),
                      Text('Petrol')
                    ],
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _selectedBrand = null;
                      _selectedBrand = null;
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 50.0,
                        width: 50.0,
                        child: Image.asset(
                          'assets/diesel.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 3.8),
                      Text('Diesel')
                    ],
                  ),
                ),

                // Checkbox(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30.0),
                //   ),
                //   value: _isDiesel,
                //   onChanged: (value) {
                //     if (value != null) {
                //       setState(() {
                //         _isDiesel = value;
                //       });
                //     }
                //   },
                // ),
                // Text('Petrol'),
                // const SizedBox(width: 4.0),
                // Checkbox(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30.0),
                //   ),
                //   value: _isDiesel,
                //   onChanged: (value) {
                //     if (value != null) {
                //       setState(() {
                //         _isDiesel = value;
                //       });
                //     }
                //   },
                // ),
                // Text('Diesel')
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return DropDownTile(
    //   label: 'Search your vehicle',
    //   onPressed: () => _showModel(context),
    // );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: Colors.grey.shade600),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text('Search your vehicles'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: _showBrandDialog,
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 35.0,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 10.0),
            //   child: BrandDropDown(),
            // ),
          ],
        ),
      ),
    );
  }
}

class BrandDropDown extends StatefulWidget {
  const BrandDropDown({Key? key}) : super(key: key);

  @override
  _BrandDropDownState createState() => _BrandDropDownState();
}

class _BrandDropDownState extends State<BrandDropDown> {
  String dropdownValue = 'BMW';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      //  isExpanded: true,
      // value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 30,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>[
        'BMW',
        'CHEVROLET',
        'FIAT',
        'FORD',
        'HONDA',
        'HYUNDAI',
        'KIA',
        'MAHINDRA',
        'MARUTI',
        'MERCEDES-BENZ',
        'NISSAN',
        'RENAULT',
        'SKODA',
        'TATA',
        'TOYOTA',
        'VW',
        'ASHOK LEYLAND',
        'AUDI',
        'BENTLEY',
        'BUGATTI',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            //height: 400.0,
            width: 150,
            child: Center(
              child: Text(
                value,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
