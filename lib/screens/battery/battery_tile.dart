import '/models/battery.dart';
import 'package:flutter/material.dart';

class BatteryTile extends StatelessWidget {
  const BatteryTile({
    Key? key,
    required this.battery,
  }) : super(key: key);

  final Battery? battery;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14.0, 20.0, 14.0, 3.0),
      child: Container(
        child: Column(
          children: [
            Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      height: 80.0,
                      width: 80.0,
                      child: Image.asset('assets/battery.png'),
                      // child: DisplayImage(
                      //   imageUrl: batteryUrl,
                      // ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      // '₹9999',
                      '₹${battery?.mrp}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 15.0),
                Container(
                  width: 175,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${battery?.type}',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2.0),
                      // Text(
                      //   // 'Model TT1001',
                      //   '${battery?.type}',
                      //   style: TextStyle(
                      //     color: Colors.grey.shade700,
                      //   ),
                      // ),
                      Text('Warrenty - ${battery?.warranty}'),
                      // Text(
                      //   'AH1 - 100AH',
                      //   style: TextStyle(
                      //     color: Colors.grey.shade700,
                      //   ),
                      // ),
                      const SizedBox(height: 30.0),
                      // Text('Dealer Price'),
                      Text('( Excluding GST )')
                    ],
                  ),
                ),
                // Spacer(),
                // Padding(
                //   padding: const EdgeInsets.only(right: 5.0),
                //   child: InkWell(
                //     onTap: () {
                //       // launch('tel://1234567890');
                //     },
                //     child: Column(
                //       children: [
                //         Icon(
                //           Icons.call,
                //           color: Colors.green,
                //         ),
                //         const SizedBox(height: 6.0),
                //         Text('Call'),
                //         Text('Distributor')
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
            const SizedBox(height: 4.5),
            Divider(
              color: Colors.grey.shade800,
            )
          ],
        ),
      ),
    );
  }
}
