import '/widgets/loading_indicator.dart';

import '/config/paths.dart';
import '/screens/amaron/upload_to_databse_button.dart';

import '/screens/battery/battery_table.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/alfa_bloc.dart';

class AlfaTab extends StatelessWidget {
  const AlfaTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlfaBloc, AlfaState>(
      listener: (context, state) {
        print('State.status ${state.status}');
      },
      builder: (context, state) {
        switch (state.status) {
          case AlfaStatus.error:
            return Center(
              child: Text('Somthing went wrong'),
            );
          case AlfaStatus.loaded:
            return Scaffold(
              floatingActionButton: UploadToDatabaseButton(
                batteries: context.read<AlfaBloc>().state.batteries,
                collectionName: Paths.alfa,
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
                            BlocProvider.of<AlfaBloc>(context)
                                .add(RefreshAlfaBatteries());
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
            return LoadingIndicator();
        }
      },
    );
  }
}
