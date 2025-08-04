import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/services/supabase/backend_points.dart';

final supabase = Supabase.instance.client;
// class ImageService {
//   final supabase = Supabase.instance.client;
//   ImageService();

//   Future<Uint8List?> pickImage({
//     required ImageSource source,
//     required ImagePicker picker,
//   }) async {
//     try {
//       final pickedFile = await picker.pickImage(source: source);
//       if (pickedFile == null) return null;
//       return await pickedFile.readAsBytes();
//     } catch (e) {
//       throw ImageServiceException('Failed to pick image: ${e.toString()}');
//     }
//   }

//   Future<String> uploadImage({
//     required Uint8List imageBytes,
//     required List<String> pathSegments,
//   }) async {
//     try {
//       final path =
//           '${pathSegments.join('/')}/${DateTime.now().millisecondsSinceEpoch}.jpg';

//       await supabase.storage.from('images').uploadBinary(path, imageBytes);

//       return supabase.storage.from('images').getPublicUrl(path);
//     } catch (e) {
//       throw ImageServiceException('Failed to upload image: ${e.toString()}');
//     }
//   }
// }

// class ImageServiceException implements Exception {
//   final String message;
//   ImageServiceException(this.message);

//   @override
//   String toString() => 'ImageServiceException: $message';
// }

class ImageService {
  Future<File?> getImageFromGallery({required picker}) async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        throw Exception('No image selected');
      }
    } catch (e) {
      throw Exception('Failed to fetch image: $e');
    }
  }

  Future<Uint8List?> getImageFromPC({required ImagePicker picker}) async {
    try {
      // Pick image from the camera
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        // Return the image bytes if the file is selected
        return await pickedFile.readAsBytes();
      } else {
        throw Exception('No image selected');
      }
    } catch (e) {
      throw Exception('Failed to fetch image: $e');
    }
  }

  Future<String?> uploadImageFromPC({required Uint8List imageBytes}) async {
    try {
      final path =
          'GoulUp/players/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final file = imageBytes;

      await supabase.storage.from('images').uploadBinary(path, file);

      final urlResponse = supabase.storage.from('images').getPublicUrl(path);

      return urlResponse; // Return the public URL of the image
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<String?> uploadPhotoFromAndroid({required File? image}) async {
    try {
      if (image == null) {
        return null;
      }

      final file = File(image.path);

      final path =
          'GoulUp/players/${DateTime.now().millisecondsSinceEpoch}.jpg';

      await supabase.storage.from(BackendPoint.imageBucket).upload(path, file);

      final urlResponse = supabase.storage
          .from(BackendPoint.imageBucket)
          .getPublicUrl(path);
      debugPrint("URL:=============> $urlResponse");
      return urlResponse;
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteOldImage(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) return;

    try {
      final uri = Uri.parse(imageUrl);
      final fullPath = uri.pathSegments
          .skipWhile((v) => v != 'images')
          .skip(1)
          .join('/');
      await supabase.storage.from(BackendPoint.imageBucket).remove([fullPath]);
    } catch (e) {
      debugPrint('Failed to delete image: $e');
    }
  }
}
