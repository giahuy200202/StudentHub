import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _seclectedImage;
  void _takePicture() async {
    final imgaepicker = ImagePicker();
    final pickedImage =
        await imgaepicker.pickImage(source: ImageSource.gallery, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _seclectedImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ElevatedButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text('Choose files to Upl'),
      onPressed: _takePicture,
    );
    if (_seclectedImage != null) {
      content = Image.file(_seclectedImage!, fit: BoxFit.cover);
    }
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      padding: EdgeInsets.all(6),
      child: Container(
          height: 180,
          width: double.infinity,
          alignment: Alignment.center,
          child: content),
    );
  }
}
