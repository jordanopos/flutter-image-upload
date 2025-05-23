import 'package:image_picker/image_picker.dart';

abstract class HomeRepository {
  Future<XFile?> pickImage(ImageSource source);
}

class HomeImpl extends HomeRepository {
  @override
  Future<XFile?> pickImage(ImageSource source) async {
    ImagePicker picker = ImagePicker();

    XFile? pickedImage = await picker.pickImage(source: source);

    return pickedImage;
  }
}
