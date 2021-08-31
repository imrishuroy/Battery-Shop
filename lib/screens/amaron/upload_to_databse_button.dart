import 'package:admin_battery/models/battery.dart';
import 'package:admin_battery/models/failure.dart';
import 'package:admin_battery/repositories/firebase/firebase_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadToDatabaseButton extends StatefulWidget {
  final List<Battery?> batteries;
  final String collectionName;

  const UploadToDatabaseButton(
      {Key? key, required this.batteries, required this.collectionName})
      : super(key: key);

  @override
  _UploadToDatabaseButtonState createState() => _UploadToDatabaseButtonState();
}

class _UploadToDatabaseButtonState extends State<UploadToDatabaseButton> {
  bool _isUploading = false;

  Future<void> _uploadToDataBase(BuildContext context) async {
    print('Batteries To Upload ${widget.batteries}');
    try {
      final result = await _askToUpload();
      print('Result $result');
      if (result) {
        print('this runs');
        setState(() {
          _isUploading = true;
        });
        //print(context.read<AmaronBloc>().state.batteries);
        final _firebaseRepo = context.read<FirebaseRepository>();
        await _firebaseRepo.uploadBattery(
            batteries: widget.batteries, collectionName: widget.collectionName);
        setState(() {
          _isUploading = false;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Added to database',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    } on Failure catch (error) {
      print(error.message);
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<bool> _askToUpload() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          title: Text(
            'Add to Database',
            style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1.2),
          ),
          content: Text('Do you want to add this table to the database ?'),
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(false),
              icon: const Icon(
                Icons.clear,
                color: Colors.red,
              ),
              label: const Text('No', style: TextStyle(color: Colors.black87)),
            ),
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(true),
              icon: const Icon(
                Icons.check,
                color: Colors.green,
              ),
              label: const Text(
                'Yes',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //  print('batteries ${widget.batteries}');
    return _isUploading
        ? Stack(
            children: [
              Positioned(
                bottom: 12.0,
                right: 17.0,
                child: CircularProgressIndicator(),
              ),
            ],
          )
        : CircleAvatar(
            radius: 30.0,
            child: IconButton(
                onPressed: () => _uploadToDataBase(context),
                icon: Icon(Icons.upload)),
          );
  }
}
