class LanguageData {
  int id;
  DateTime createAt;
  DateTime updateAt;
  String deteleAt;
  int studentid;
  String languageName;
  String level;

  LanguageData(
      {required this.id,
      required this.createAt,
      required this.updateAt,
      required this.deteleAt,
      required this.studentid,
      required this.languageName,
      required this.level});
}
