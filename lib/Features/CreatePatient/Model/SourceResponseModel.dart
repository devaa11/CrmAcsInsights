

class SourceItem {
  final int id;
  final String name;

  SourceItem({required this.id, required this.name});
}
class SourceResponseModel {
  List<Sources>? sources;

  SourceResponseModel({this.sources});

  SourceResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['sources'] != null) {
      sources = <Sources>[];
      json['sources'].forEach((v) {
        sources!.add(new Sources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sources != null) {
      data['sources'] = this.sources!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sources {
  int? id;
  String? name;

  Sources(
      {this.id,
        this.name,
       });

  Sources.fromJson(Map<String, dynamic> json) {
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
