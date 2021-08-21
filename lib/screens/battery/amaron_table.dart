import 'package:admin_battery/models/battery.dart';
import 'package:admin_battery/widgets/table_entry_text.dart';
import 'package:admin_battery/widgets/table_heading_text.dart';

import 'package:flutter/material.dart';

class AmaronTable extends StatelessWidget {
  final List<Battery?> amaron;

  const AmaronTable({Key? key, required this.amaron}) : super(key: key);

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
                    for (var item in amaron)
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: TableEntryText(
                              value: item?.type,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          TableEntryText(value: '${item?.ratting}'),
                          TableEntryText(value: '${item?.warranty}'),
                          TableEntryText(value: '${item?.price}'),
                          TableEntryText(value: '${item?.mrp}'),
                          TableEntryText(value: '${item?.scrap}'),
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
