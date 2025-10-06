
class SymptomItem {
  final int id;
  final String name;

  SymptomItem({required this.id, required this.name});
}



class SymptomsModel {
  List<Symptons>? symptons;

  SymptomsModel({this.symptons});

  SymptomsModel.fromJson(Map<String, dynamic> json) {
    if (json['symptoms'] != null) {
      symptons = <Symptons>[];
      json['symptoms'].forEach((v) {
        symptons!.add(new Symptons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.symptons != null) {
      data['symptoms'] = this.symptons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Symptons {
  int? id;
  String? name;


  Symptons({this.id, this.name});

  Symptons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }
}
