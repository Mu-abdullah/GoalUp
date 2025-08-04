import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../new_player/data/repo/get_image.dart';

part 'update_image_state.dart';

class UpdateImageCubit extends Cubit<UpdateImageState> {
  UpdateImageCubit() : super(UpdateImageInitial());
  static UpdateImageCubit get(context) => BlocProvider.of(context);
  ImageService repo = ImageService();

  File? image;
  final ImagePicker picker = ImagePicker();
  String? imagePath;
  String? imageUrl;
  Uint8List? pickedBytes;

  Future<void> pickImage() async {
    emit(GetImageLoading());
    try {
      if (kIsWeb) {
        pickedBytes = await repo.getImageFromPC(picker: picker);
      } else {
        image = await repo.getImageFromGallery(picker: picker);
      }
      emit(GetImageLoaded());
    } catch (e) {
      emit(GetImageError(e.toString()));
    }
  }
}
