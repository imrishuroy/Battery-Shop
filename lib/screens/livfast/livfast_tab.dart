import '/widgets/loading_indicator.dart';

import '/config/paths.dart';
import '/screens/amaron/upload_to_databse_button.dart';

import '/screens/battery/battery_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/livfast_bloc.dart';

class LivFastTab extends StatelessWidget {
  const LivFastTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LivFastBloc, LivFastState>(
      listener: (context, state) {
        print('State.status ${state.status}');
      },
      builder: (context, state) {
        switch (state.status) {
          case LivFastStatus.error:
            return Center(
              child: Text('Somthing went wrong'),
            );
          case LivFastStatus.loaded:
            return Scaffold(
              floatingActionButton: UploadToDatabaseButton(
                batteries: context.read<LivFastBloc>().state.batteries,
                collectionName: Paths.livFast,
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
                            BlocProvider.of<LivFastBloc>(context)
                                .add(RefreshLivFastBatteries());
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
