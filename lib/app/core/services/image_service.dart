import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImageService {
  Future<File?> getImage({bool isCamera = true});
}

class ImageServiceImpl implements ImageService {
  final ImagePicker _imagePicker;

  ImageServiceImpl(this._imagePicker);

  @override
  Future<File?> getImage({bool isCamera = true}) async {
    final image = await _imagePicker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (image == null) {
      return null;
    }
    return File(image.path);
  }
}
