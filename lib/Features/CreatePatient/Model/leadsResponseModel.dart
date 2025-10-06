class LeadsResponseModel {
  List<Leads>? leads;

  LeadsResponseModel({this.leads});

  LeadsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['leads'] != null) {
      leads = <Leads>[];
      json['leads'].forEach((v) {
        leads!.add(new Leads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leads != null) {
      data['leads'] = this.leads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leads {
  int? id;
  String? name;
  String? phoneNumber;
  String? location;
  int? age;
  Source? source;
  List<LeadsSymtoms>? symptoms;
  String? procedure;

  Status? status;
  String? createdAt;
  String? updatedAt;

  Leads(
      {this.id,
        this.name,
        this.phoneNumber,
        this.location,
        this.age,
        this.source,
        this.symptoms,
        this.status,
        this.procedure,

        this.createdAt,
        this.updatedAt});

  Leads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    location = json['location'];
    age = json['age'];
    procedure = json['procedure'];
    source =
    json['source'] != null ? new Source.fromJson(json['source']) : null;
    if (json['symptoms'] != null) {
      symptoms = <LeadsSymtoms>[];
      json['symptoms'].forEach((v) {
        symptoms!.add(new LeadsSymtoms.fromJson(v));
      });
    }
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['location'] = this.location;
    data['age'] = this.age;
    data['procedure'] = this.procedure;
    if (this.source != null) {
      data['source'] = this.source!.toJson();
    }
    if (this.symptoms != null) {
      data['symptoms'] = this.symptoms!.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Source {
  int? id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
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

class LeadsSymtoms {
  int? id;
  String? name;

  LeadsSymtoms({this.id, this.name});

  LeadsSymtoms.fromJson(Map<String, dynamic> json) {
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

class Status {
  String? id;
  String? name;
  String? color;

  Status({this.id, this.name, this.color});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    return data;
  }
}


