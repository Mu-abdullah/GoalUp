import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repo/get_image.dart';

part 'get_image_state.dart';

class GetImageCubit extends Cubit<GetImageState> {
  GetImageCubit() : super(GetImageInitial());
  static GetImageCubit get(context) => BlocProvider.of(context);
  ImageService imageService = ImageService();

  File? image;
  final ImagePicker picker = ImagePicker();
  String? imagePath;
  String? imageUrl;
  Uint8List? pickedBytes;

  Future<void> pickImage() async {
    emit(GetImageLoading());
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        image = await imageService.getImageFromGallery(picker: picker);
      } else if (kIsWeb) {
        pickedBytes = await imageService.getImageFromPC(picker: picker);
      }
      emit(GetImageLoaded());
    } catch (e) {
      emit(GetImageError(e.toString()));
    }
  }

  Future<String?> uploadPhoto() async {
    emit(UploadImageLoading());

    if (image == null) {
      emit(UploadImageFailed(error: "No image selected"));
      return null;
    }

    try {
      final uploadTask = await imageService.uploadPhotoFromAndroid(
        image: image,
      );

      if (uploadTask != null) {
        imageUrl = uploadTask;
        emit(UploadImageSuccess());
        debugPrint('uploaded image: $imageUrl');
        return imageUrl;
      } else {
        emit(UploadImageFailed(error: "Failed to upload image"));
        return null;
      }
    } catch (e) {
      debugPrint('Error uploading image: $e');
      emit(UploadImageFailed(error: e.toString()));
      return null;
    }
  }
}
