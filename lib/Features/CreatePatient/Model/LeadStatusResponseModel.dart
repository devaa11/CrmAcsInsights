class PatientStatusResponseModel {
  List<PatientStatus>? status;

  PatientStatusResponseModel({this.status});

  PatientStatusResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['status'] != null) {
      status = <PatientStatus>[];
      json['status'].forEach((v) {
        status!.add(new PatientStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatientStatus {
  String? id;
  String? label;

  PatientStatus({this.id, this.label});

  PatientStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    return data;
  }
}
