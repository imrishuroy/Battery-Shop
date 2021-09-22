import '/models/battery.dart';
import '/widgets/table_entry_text.dart';
import '/widgets/table_heading_text.dart';

import 'package:flutter/material.dart';

class BatteryTable extends StatelessWidget {
  final List<Battery?> batteries;

  const BatteryTable({Key? key, required this.batteries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(120.0),
                  border: TableBorder.all(
                      color: Colors.black, style: BorderStyle.solid, width: 2),
                  children: [
                    TableRow(
                      children: [
                        TableHeadingText(label: 'S.N0.'),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
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
                          TableEntryText(value: '${batteries[i]?.ratting}'),
                          TableEntryText(value: '${batteries[i]?.warranty}'),
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
  }
}
