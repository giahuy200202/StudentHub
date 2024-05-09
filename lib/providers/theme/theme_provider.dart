import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorApp {
  Color? colorBackgroundColor;
  Color? colorTitle;
  Color? colorText;
  Color? colorBorderSide;
  Color? colorBorderBackground;
  Color? colorDivider;
  Color? colorSignIn;
  Color? colorIcon;
  Color? colorButton;
  Color? colorEnableButton;
  Color? colorBackgroundBootomSheet;
  Color? colorSelect;
  Color? colorunSelect;
  Color? colorWhiteBlack;
  Color? colorBlackWhite;
  Color? colorBlack;
  Color? colorBorderSideMutil;
  Color? colorClip;
  Color? colorTime;
  Color? colorBoderSwitch;
  Color? colorTextSwitch;
  Color? colorIconSwitch;
  Color? colorGrey;
  Color? colorCreate;
  Color? colorApply;
  ColorApp(
      {this.colorBackgroundColor,
      this.colorTitle,
      this.colorText,
      this.colorBorderSide,
      this.colorBorderBackground,
      this.colorDivider,
      this.colorSignIn,
      this.colorIcon,
      this.colorButton,
      this.colorEnableButton,
      this.colorBackgroundBootomSheet,
      this.colorSelect,
      this.colorunSelect,
      this.colorWhiteBlack,
      this.colorBlackWhite,
      this.colorBlack = Colors.black,
      this.colorBorderSideMutil,
      this.colorClip,
      this.colorTime,
      this.colorBoderSwitch,
      this.colorTextSwitch,
      this.colorIconSwitch,
      this.colorGrey = Colors.grey,
      this.colorCreate,
      this.colorApply});
}

class _ColorApp extends StateNotifier<ColorApp> {
  _ColorApp()
      : super(ColorApp(
          colorBackgroundColor: Colors.white,
          colorTitle: Colors.black,
          colorText: Colors.black,
          colorBorderSide: Colors.black,
          colorBorderBackground: Colors.white,
          colorDivider: Colors.black,
          colorSignIn: Colors.white,
          colorIcon: Colors.black,
          colorButton: Colors.grey[300]!,
          colorEnableButton: Colors.black,
          colorBackgroundBootomSheet: Colors.white,
          colorSelect: Colors.black,
          colorunSelect: Colors.white,
          colorWhiteBlack: Colors.white,
          colorBlackWhite: Colors.black,
          colorBorderSideMutil: Colors.black,
          colorClip: Color.fromARGB(255, 193, 191, 191),
          colorTime: Color.fromARGB(255, 94, 94, 94),
          colorBoderSwitch: Color.fromARGB(255, 73, 80, 87),
          colorIconSwitch: Color.fromARGB(255, 121, 123, 125),
          colorCreate: Color.fromARGB(255, 94, 94, 94),
          colorApply: Colors.white,
        ));

  var isDarkMode = false;

  void setLightMode() {
    isDarkMode = false;
    setcolorlightMode();
  }

  void setDarkMode() {
    isDarkMode = true;
    setcolordarktMode();
  }

  void setcolorlightMode() {
    ColorApp tmp = ColorApp(
      colorTitle: Colors.black,
      colorText: Colors.black,
      colorBorderSide: Colors.black,
      colorDivider: Colors.black,
      colorBorderBackground: Colors.white,
      colorBackgroundColor: Colors.white,
      colorSignIn: Colors.white,
      colorIcon: Colors.black,
      colorButton: Colors.grey[300]!,
      colorEnableButton: Colors.black,
      colorBackgroundBootomSheet: Colors.white,
      colorSelect: Colors.black,
      colorunSelect: Colors.white,
      colorWhiteBlack: Colors.white,
      colorBlackWhite: Colors.black,
      colorBorderSideMutil: Colors.grey,
      colorClip: Color.fromARGB(255, 193, 191, 191),
      colorTime: Color.fromARGB(255, 94, 94, 94),
      colorTextSwitch: Color.fromARGB(255, 73, 80, 87),
      colorBoderSwitch: Color.fromARGB(255, 73, 80, 87),
      colorIconSwitch: Color.fromARGB(255, 121, 123, 125),
      colorCreate: Color.fromARGB(255, 94, 94, 94),
      colorApply: Colors.white,
    );
    state = tmp;
  }

  void setcolordarktMode() {
    ColorApp tmp = ColorApp(
      colorTitle: Colors.white,
      colorText: Colors.grey[300]!,
      colorBorderSide: Colors.grey,
      colorDivider: Colors.grey,
      colorBorderBackground: Colors.grey[800]!,
      colorBackgroundColor: Colors.grey[900]!,
      colorSignIn: Colors.white,
      colorIcon: Colors.grey,
      colorButton: Color.fromARGB(64, 158, 158, 158),
      colorEnableButton: Colors.grey[800]!,
      //mutilselect set color
      colorBackgroundBootomSheet: Color.fromARGB(255, 44, 44, 44),
      colorSelect: Colors.grey[400]!,
      colorunSelect: Colors.grey[900]!,
      colorWhiteBlack: Colors.black,
      colorBlackWhite: Colors.white,
      colorBorderSideMutil: Color.fromARGB(255, 44, 44, 44),
      colorClip: Colors.black,
      colorTime: Colors.grey[300]!,
      colorTextSwitch: Colors.grey[300]!,
      colorBoderSwitch: Colors.grey,
      colorIconSwitch: Colors.grey[300]!,
      colorCreate: Colors.grey[400]!,
      colorApply: Color.fromARGB(64, 158, 158, 158),
    );
    state = tmp;
  }
}

final colorProvider = StateNotifierProvider<_ColorApp, ColorApp>((ref) => _ColorApp());
