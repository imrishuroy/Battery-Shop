import 'dart:io';
import 'package:admin_battery/enums/enums.dart';
import 'package:admin_battery/models/vehicle.dart';
import 'package:admin_battery/repositories/firebase_services.dart';
import 'package:admin_battery/repositories/storage/storage_repo.dart';
import 'package:admin_battery/widgets/loading_indicator.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:uuid/uuid.dart';

class AddVehicleToBrand extends StatefulWidget {
  final String? vehicleBrandId;
  final FuelType? fuelType;

  const AddVehicleToBrand({
    Key? key,
    required this.vehicleBrandId,
    required this.fuelType,
  }) : super(key: key);

  @override
  _AddVehicleToBrandState createState() => _AddVehicleToBrandState();
}

class _AddVehicleToBrandState extends State<AddVehicleToBrand> {
  void _pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();

    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    print('Image $pickedImage');
    print('Image ${pickedImage?.path}');
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _file = pickedImage;
      });
    }
  }

  void deleteImage(BuildContext context) async {
    final _storage = context.read<StorageRepository>();
    await _storage.deleteUploadedImage();
  }

  File? _image;
  XFile? _file;

  final _formKey = GlobalKey<FormState>();
  String? _name;

  bool _isLoading = false;

  void _submit() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          _isLoading = true;
        });
        final _storageRepo = context.read<StorageRepository>();
        final _firebaseService = context.read<FirebaseServices>();
        if (_file != null) {
          final id = Uuid().v4();
          final imageUrl =
              await _storageRepo.uploadImageWeb(file: _file!, id: id);
          final vehicle =
              Vehicle(vehicleId: id, name: _name, imageUrl: imageUrl);

          await _firebaseService.addVehicleToBrand(
              fuelType: widget.fuelType,
              vehicleBrandId: widget.vehicleBrandId,
              vehicle: vehicle);
        }
      }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } catch (error) {
      print('Error Submitting brand ${error.toString()}');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('File image $_image');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add New Vehicle'),
      ),
      body: _isLoading
          ? LoadingIndicator()
          : ResponsiveBuilder(
              builder: (context, size) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30.0),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border:
                                  Border.all(color: Colors.blueGrey.shade500),
                            ),
                            height: 220.0,
                            width: 220.0,
                            child: _image == null
                                ? Center(
                                    child: ElevatedButton(
                                      child: Text('Add Image'),
                                      onPressed: () => _pickImage(context),
                                    ),
                                  )
                                : Image.network(
                                    _image!.path,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            onSaved: (value) => _name = value,
                            validator: (value) =>
                                value!.isEmpty ? 'Name can\'t be empty' : null,
                            decoration: InputDecoration(
                              hintText: 'Enter vehicle Name',
                              labelText: 'Brand Name',
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(5.0),
                              // ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50.0),
                        SizedBox(
                          height: 40.0,
                          width: 160.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: _submit,
                            child: Text('Submit'),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
