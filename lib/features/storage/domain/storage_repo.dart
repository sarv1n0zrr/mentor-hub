// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:firebase_storage/firebase_storage.dart';
//
// abstract class StorageRepo {
//   // upload profile images on mobile platforms
//   Future<String?> uploadProfileImageMobile(String path, String fileName);
//
//   // upload profile images on web platforms
//   Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName);
//
//   // upload post images on mobile platforms
//   Future<String?> uploadPostImageMobile(String path, String fileName);
//
//   // upload post images on web platforms
//   Future<String?> uploadPostImageWeb(Uint8List fileBytes, String fileName);
// }
//
// class StorageRepos {
//   final FirebaseStorage storage = FirebaseStorage.instance;
//
//   Future<String?> uploadImageWeb(Uint8List fileBytes) async {
//     try {
//       final ref = storage
//           .ref()
//           .child('post_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
//       await ref.putData(fileBytes);
//       return await ref.getDownloadURL();
//     } catch (e) {
//       print('Error uploading image: $e');
//       return null;
//     }
//   }
//
//   Future<String?> uploadImageMobile(String filePath) async {
//     try {
//       final ref = storage
//           .ref()
//           .child('post_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
//       await ref.putFile(File(filePath));
//       return await ref.getDownloadURL();
//     } catch (e) {
//       print('Error uploading image: $e');
//       return null;
//     }
//   }
// }

import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

// Abstract class defining the contract
abstract class StorageRepo {
  // Upload profile images
  Future<String?> uploadProfileImageMobile(String path, String fileName);
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName);

  // Upload post images
  Future<String?> uploadPostImageMobile(String path, String fileName);
  Future<String?> uploadPostImageWeb(Uint8List fileBytes, String fileName);
}

// Implementation of StorageRepo
class FirebaseStorageRepo implements StorageRepo {
  final FirebaseStorage storage = FirebaseStorage.instance;

  // Upload profile images (Mobile)
  @override
  Future<String?> uploadProfileImageMobile(String path, String fileName) {
    return _uploadFile(path, fileName, 'profile_images');
  }

  // Upload profile images (Web)
  @override
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName) {
    return _uploadFileBytes(fileBytes, fileName, 'profile_images');
  }

  // Upload post images (Mobile)
  @override
  Future<String?> uploadPostImageMobile(String path, String fileName) {
    return _uploadFile(path, fileName, 'post_images');
  }

  // Upload post images (Web)
  @override
  Future<String?> uploadPostImageWeb(Uint8List fileBytes, String fileName) {
    return _uploadFileBytes(fileBytes, fileName, 'post_images');
  }

  // Helper method for mobile (File)
  Future<String?> _uploadFile(
      String path, String fileName, String folder) async {
    try {
      final file = File(path);
      final ref = storage.ref().child('$folder/$fileName');
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  // Helper method for web (Bytes)
  Future<String?> _uploadFileBytes(
      Uint8List fileBytes, String fileName, String folder) async {
    try {
      final ref = storage.ref().child('$folder/$fileName');
      await ref.putData(fileBytes);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }
}
