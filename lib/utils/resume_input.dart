import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:studenthub/providers/language/language.provider.dart';
import 'package:studenthub/providers/profile/student_input.provider.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';

class ResumeInput extends ConsumerStatefulWidget {
  const ResumeInput({super.key});

  @override
  ConsumerState<ResumeInput> createState() {
    return _ResumeInputState();
  }
}

class _ResumeInputState extends ConsumerState<ResumeInput> {
  void _takePicture() async {
    final imagepicker = ImagePicker();
    final pickedImage = await imagepicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    ref.read(studentInputProvider.notifier).setStudentInputResume(
          File(pickedImage.path).path,
        );
  }

  @override
  Widget build(BuildContext context) {
    final studentInput = ref.watch(studentInputProvider);
    var colorApp = ref.watch(colorProvider);

    // Widget content = ElevatedButton.icon(
    //   icon: const Icon(Icons.camera),
    //   label: const Text('Choose files to Url'),
    var Language = ref.watch(LanguageProvider);

    Widget content = ElevatedButton.icon(
      icon: const Icon(Icons.camera),
      label: Text(Language.Choosefile),
      onPressed: _takePicture,
    );

    if ((studentInput.resume != null && studentInput.resume != '')) {
      if (studentInput.resume != null && studentInput.resume!.substring(0, 4) == 'http') {
        content = Image.network(
          studentInput.resume!,
          fit: BoxFit.cover,
        );
      } else {
        content = Image.file(File(studentInput.resume!), fit: BoxFit.cover);
      }
    }
    return DottedBorder(
      color: colorApp.colorBorderSide as Color,
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      padding: const EdgeInsets.all(6),
      child: Container(
        height: 180,
        width: double.infinity,
        alignment: Alignment.center,
        child: content,
      ),
    );
  }
}
