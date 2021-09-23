import '/widgets/loading_indicator.dart';

import '/config/paths.dart';
import '/screens/amaron/upload_to_databse_button.dart';

import '/screens/battery/battery_table.dart';
import '/screens/exide/bloc/exide_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExideTab extends StatelessWidget {
  const ExideTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExideBloc, ExideState>(
      listener: (context, state) {
        print('State.status ${state.status}');
      },
      builder: (context, state) {
        switch (state.status) {
          case ExideStatus.error:
            return Center(
              child: Text('Somthing went wrong'),
            );
          case ExideStatus.loaded:
            return Scaffold(
              floatingActionButton: UploadToDatabaseButton(
                batteries: context.read<ExideBloc>().state.batteries,
                collectionName: Paths.exide,
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
                            BlocProvider.of<ExideBloc>(context)
                                .add(RefreshExideBatteries());
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

//     return BlocConsumer<ExideBloc, ExideState>(listener: (context, state) {
//       print('State of exide tab ${state.status}');
//     }, builder: (context, state) {
//       switch (state.status) {
//         case ExideStatus.error:
//           return Center(
//             child: Text('Something went wrong'),
//           );

//         case ExideStatus.loaded:
//           return Scaffold(
//             floatingActionButton: UploadToDatabaseButton(
//               batteries: context.read<ExideBloc>().state.batteries,
//               collectionName: Paths.exide,
//             ),
//             body: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 10.0, top: 10.0),
//                       child: IconButton(
//                         onPressed: () {
//                           BlocProvider.of<ExideBloc>(context)
//                               .add(RefreshExideBatteries());
//                         },
//                         icon: Icon(
//                           Icons.refresh,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Expanded(child: BatteryTable(batteries: state.batteries)),
//               ],
//             ),
//           );
//         default:
//           return LoadingIndicator();
//       }
//     });
//   }
// }
