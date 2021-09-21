import '/models/battery.dart';
import '/repository/rest-apis/rest_apis_repo.dart';
import 'package:flutter/material.dart';
import 'widgets/table_entry.dart';
import 'widgets/table_header_txt.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class BatteryTable extends StatelessWidget {
  final String url;
  final String batteryBrand;

  const BatteryTable({Key? key, required this.url, required this.batteryBrand})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _restApisRepo = context.read<RestApisRepository>();
    return Scaffold(
      appBar: AppBar(
        title: Text(batteryBrand),
      ),
      body: FutureBuilder<List<Battery?>>(
        future: _restApisRepo.getBatteries(url),
        builder: (context, snaphsot) {
          if (snaphsot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                children: const <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 5.0),
                  Text('Loading please wait...')
                ],
              ),
            );
          }

          final batteries = snaphsot.data;
          if (batteries == null) {
            return const Center(child: Text('No data found :('));
          }
          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Table(
                        defaultColumnWidth: const FixedColumnWidth(120.0),
                        border: TableBorder.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 2),
                        children: [
                          const TableRow(
                            children: [
                              TableHeadingText(label: 'S.N0.'),
                              Padding(
                                padding: EdgeInsets.only(left: 6.0),
                                child: TableHeadingText(
                                  label: 'TYPE',
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              TableHeadingText(label: 'AH RATING'),
                              TableHeadingText(label: 'WARRANTY'),
                              TableHeadingText(label: 'DP PRICE'),
                              TableHeadingText(label: 'MRP'),
                              TableHeadingText(label: 'SCRAP'),
                            ],
                          ),
                          for (int i = 0; i < batteries.length; i++)
                            //   for (var amaronBatteries[i] in amaronBatteries)

                            TableRow(
                              children: [
                                TableEntryText(value: '${i + 1}'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
                                  child: TableEntryText(
                                    value: batteries[i]?.type,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                TableEntryText(
                                    value: '${batteries[i]?.ratting}'),
                                TableEntryText(
                                    value: '${batteries[i]?.warranty}'),
                                TableEntryText(value: '${batteries[i]?.price}'),
                                TableEntryText(value: '${batteries[i]?.mrp}'),
                                TableEntryText(value: '${batteries[i]?.scrap}'),
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
