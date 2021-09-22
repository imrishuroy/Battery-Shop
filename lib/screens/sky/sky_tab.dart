import '/config/paths.dart';
import '/screens/amaron/upload_to_databse_button.dart';

import '/screens/battery/battery_table.dart';
import '/screens/sky/bloc/sky_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkyTab extends StatelessWidget {
  const SkyTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SkyBloc, SkyState>(
      listener: (context, state) {
        print('State.status ${state.status}');
      },
      builder: (context, state) {
        switch (state.status) {
          case SkyStatus.error:
            return Center(
              child: Text('Somthing went wrong'),
            );
          case SkyStatus.loaded:
            return Scaffold(
              floatingActionButton: UploadToDatabaseButton(
                batteries: context.read<SkyBloc>().state.batteries,
                collectionName: Paths.sky,
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
                            BlocProvider.of<SkyBloc>(context)
                                .add(RefreshSkyBatteries());
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
