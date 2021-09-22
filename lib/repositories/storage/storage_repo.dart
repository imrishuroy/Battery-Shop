import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:uuid/uuid.dart';

import 'base_storage_repo.dart';

class StorageRepository extends BaseStorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({FirebaseStorage? firebaseStorage})
      : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<String> _uploadImage({
    required File image,
    required String ref,
  }) async {
    final downloadUrl = await _firebaseStorage
        .ref(ref)
        .putFile(image)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
    return downloadUrl;
  }

  Future<String?> uploadImageWeb(
      {required XFile file, required String id, required String path}) async {
    final downloadUrl = await _firebaseStorage
        .ref()
        .child('$path/$id')
        .putData(await file.readAsBytes(),
            SettableMetadata(contentType: 'image/jpeg'))
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
    return downloadUrl;
  }

  Future deleteUploadedImage() async {
    await _firebaseStorage
        .ref()
        .child('images/0a54cc85-f7ce-40ee-b61b-712ed588ff96')
        .delete();
  }

  @override
  Future<String> uploadProfileImage({
    required String url,
    required File image,
  }) async {
    var imageId = Uuid().v4();

    // Update user profile image.
    if (url.isNotEmpty) {
      final exp = RegExp(r'userProfile_(.*).jpg');
      imageId = exp.firstMatch(url)![1]!;
    }

    final downloadUrl = await _uploadImage(
      image: image,
      ref: 'images/users/userProfile_$imageId.jpg',
    );
    return downloadUrl;
  }

  @override
  Future<String> uploadPostImage({required File image}) async {
    final imageId = Uuid().v4();
    final downloadUrl = await _uploadImage(
      image: image,
      ref: 'images/posts/post_$imageId.jpg',
    );
    return downloadUrl;
  }
}


 // Reference _reference =
        //     _storage.ref().child('images/${Path.basename(image.path)}');
        // await _reference
        //     .putData(
        //   await image.readAsBytes(),
        //   SettableMetadata(contentType: 'image/jpeg'),
        // )
        //     .whenComplete(() async {
        //   await _reference.getDownloadURL().then((value) {
        //     // uploadedPhotoUrl = value;
        //     print('Download URL $value');
        //   });
        // });