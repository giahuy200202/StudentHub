import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:studenthub/providers/profile/student_input.provider.dart';
import 'package:studenthub/providers/language/language.provider.dart';

class TrasncriptInput extends ConsumerStatefulWidget {
  const TrasncriptInput({super.key});

  @override
  ConsumerState<TrasncriptInput> createState() {
    return _TrasncriptInputState();
  }
}

class _TrasncriptInputState extends ConsumerState<TrasncriptInput> {
  void _takePicture() async {
    final imagepicker = ImagePicker();
    final pickedImage = await imagepicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    ref.read(studentInputProvider.notifier).setStudentInputTranscript(
          File(pickedImage.path).path,
        );
  }

  @override
  Widget build(BuildContext context) {
    final studentInput = ref.watch(studentInputProvider);
    var Language = ref.watch(LanguageProvider);
    Widget content = ElevatedButton.icon(
      icon: const Icon(Icons.camera),
      label: Text(Language.Choosefile),
      onPressed: _takePicture,
    );

    if ((studentInput.transcript != null && studentInput.transcript != '')) {
      if (studentInput.transcript != null && studentInput.transcript!.substring(0, 4) == 'http') {
        content = Image.network(
          studentInput.transcript!,
          fit: BoxFit.cover,
        );
      } else {
        content = Image.file(File(studentInput.transcript!), fit: BoxFit.cover);
      }
    }
    return DottedBorder(
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
