import '/models/inverter_wave.dart';
import '/repository/rest-apis/rest_apis_repo.dart';
import '/screens/price-list/widgets/table_entry.dart';
import '/screens/price-list/widgets/table_header_txt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InverterExcel extends StatelessWidget {
  final String url;
  final String inverterWave;

  const InverterExcel({Key? key, required this.url, required this.inverterWave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _restRepo = context.read<RestApisRepository>();
    return Scaffold(
      appBar: AppBar(
        title: Text(inverterWave),
      ),
      body: FutureBuilder<List<InverterWave?>>(
        future: _restRepo.getWaveInverter(url),
        builder: (context, snaphsot) {
          if (snaphsot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final inverters = snaphsot.data;

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
                                  label: 'M0DEL',
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              TableHeadingText(label: 'DEALER PRICE'),
                              TableHeadingText(label: 'MRP'),
                            ],
                          ),
                          for (int i = 0; i < inverters!.length; i++)
                            TableRow(
                              children: [
                                TableEntryText(value: '${i + 1}'),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.top,
                                  child: SizedBox(
                                    height: 52,
                                    width: 102,
                                    // color: Colors.red,
                                    child: Center(
                                      child: Text(
                                        inverters[i]?.model ?? 'N/A',
                                        style: const TextStyle(fontSize: 16.0),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),

                                TableEntryText(
                                    value: '${inverters[i]?.dealerPrice}'),
                                TableEntryText(value: '${inverters[i]?.mrp}'),

                                // TableEntryText(value: '${batteries[i]?.mrp}'),
                                // TableEntryText(value: '${batteries[i]?.scrap}'),
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
