import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';

class ExcelScreen extends StatefulWidget {
  const ExcelScreen({Key? key}) : super(key: key);

  @override
  _ExcelScreenState createState() => _ExcelScreenState();
}

class _ExcelScreenState extends State<ExcelScreen> {
  File? _file;
  List<Data?> _rowData = [];
  // List<List<Data?>> _columnData = [];
  List<Map<String, dynamic>> _myData = [];

  _pickFile() async {
    try {
      // final FilePickerResult? result = await FilePicker.platform.pickFiles();
      // print('Result ${result!.files.first.bytes}');
      // if (result != null) {
      //   File file = File(result.files.single.path!);
      //   print('File $file');
      //   setState(() {
      //     _file = file;
      //   });
      // }

      /// Use FilePicker to pick files in Flutter Web

      FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
        allowMultiple: false,
      );

      /// file might be picked

      if (pickedFile != null) {
        var bytes = pickedFile.files.single.bytes;
        var excel = Excel.decodeBytes(bytes!);
        var sheet = excel.sheets['Table 1'];
        var cell = sheet?.cell(CellIndex.indexByString('A1'));
        print('Cell $cell');

        /// Iterating and changing values to desired type
        for (int row = 0; row < sheet!.maxRows; row++) {
          sheet.row(row).forEach((cell) {
            var val = cell!.value; //  Value stored in the particular cell
            print('Value $val');
            // cell.value = ' My custom Value ';
          });
        }

        // print('Sheets ${excel.sheets.entries.first.value.rows}');
        for (var table in excel.tables.keys) {
          /// print(table); //sheet Name
          // print('Max Cols ${excel.tables[table]!.maxCols}');
          // print(excel.tables[table]!.maxRows);

          //_rowData.add(excel.tables[table]!.rows);

          for (var row in excel.tables[table]!.rows) {
            for (var item in row) {
              Map<String, dynamic> data = {};
              //  data['type'] = item?;

              data['rating'] = item?.value;
              _myData.add(data);

              _rowData.add(item);
            }
            //  _rowData.add(row);
            //List<Data?> data = row;
            //_rowData.addAll(row);
            // print('Row ${row[1]!.value}');
          }
          setState(() {});

          // for (var row in excel.tables[table]!.rows) {
          //   //   print("$row");
          //   for (var item in row) {
          //     print('Sheet name ${item!.sheetName}');
          //     print('Value ${item.value}');
          //   }
          // }
        }
      }
    } catch (error) {
      print('Error picking file ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Row Data $_rowData');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _pickFile,
        child: (Icon(Icons.add)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: _myData.length,
              itemBuilder: (context, index) {
                final data = _myData[index];

                return Text('${data['type']}');
              },
            ),
          ),
          Text('Picked Path ${_file?.path}'),
          ElevatedButton(
            onPressed: () {},
            child: Text('Get Excel'),
          )
        ],
      ),
    );
  }
}
