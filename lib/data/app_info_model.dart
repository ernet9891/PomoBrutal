import 'dart:typed_data';


class AppInfoModel {
  String appName;
  String packageName;
  Uint8List? icon;
  bool isSelected;

  AppInfoModel({
    required this.appName,
    required this.packageName,
    required this.icon,
    required this.isSelected
  });

}