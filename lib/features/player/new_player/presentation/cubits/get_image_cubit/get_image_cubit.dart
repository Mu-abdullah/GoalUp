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
  Uint8List? pickedBytes;

  final ImagePicker picker = ImagePicker();

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
}
