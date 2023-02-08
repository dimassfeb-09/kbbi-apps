class KBBIModel {
  late String title;
  late List desc;

  KBBIModel.fromJson(Map<String, dynamic> data) {
    title = data["lema"];
    desc = data["arti"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["lema"] = title;
    data["arti"] = desc;

    return data;
  }
}
