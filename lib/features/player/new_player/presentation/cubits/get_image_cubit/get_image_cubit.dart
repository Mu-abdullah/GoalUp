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
      if (kIsWeb) {
        pickedBytes = await imageService.getImageFromPC(picker: picker);
      } else {
        image = await imageService.getImageFromGallery(picker: picker);
      }
      emit(GetImageLoaded());
    } catch (e) {
      emit(GetImageError(e.toString()));
    }
  }

  Future<String?> uploadPhoto() async {
    emit(UploadImageLoading());

    try {
      String? uploadUrl;

      if (kIsWeb) {
        if (pickedBytes == null) {
          emit(UploadImageFailed(error: "No image selected"));
          return null;
        }

        uploadUrl = await imageService.uploadImageFromPC(
          imageBytes: pickedBytes!,
        );
      } else {
        if (image == null) {
          emit(UploadImageFailed(error: "No image selected"));
          return null;
        }

        uploadUrl = await imageService.uploadPhotoFromAndroid(image: image);
      }

      if (uploadUrl != null) {
        imageUrl = uploadUrl;
        emit(UploadImageSuccess());
        return uploadUrl;
      } else {
        emit(UploadImageFailed(error: "Upload failed"));
        return null;
      }
    } catch (e) {
      emit(UploadImageFailed(error: e.toString()));
      return null;
    }
  }
}
