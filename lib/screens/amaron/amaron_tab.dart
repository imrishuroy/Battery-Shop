import '/config/paths.dart';
import '/screens/amaron/bloc/amaron_bloc.dart';
import '/screens/amaron/upload_to_databse_button.dart';

import '/screens/battery/battery_table.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmaronTab extends StatelessWidget {
  const AmaronTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AmaronBloc, AmaronState>(
      listener: (context, state) {
        print('State.status ${state.status}');
      },
      builder: (context, state) {
        switch (state.status) {
          case AmaronStatus.error:
            return Center(
              child: Text('Somthing went wrong'),
            );
          case AmaronStatus.loaded:
            return Scaffold(
              floatingActionButton: UploadToDatabaseButton(
                batteries: context.read<AmaronBloc>().state.batteries,
                collectionName: Paths.amaron,
              ),
              body: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0, top: 10.0),
                        child: IconButton(
                          onPressed: () {
                            BlocProvider.of<AmaronBloc>(context)
                                .add(RefreshAmaronBatteries());
                          },
                          icon: Icon(
                            Icons.refresh,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: BatteryTable(batteries: state.batteries),
                  ),
                ],
              ),
            );

          default:
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
