class SinglePatientResponseModel {
  Lead? lead;

  SinglePatientResponseModel({this.lead});

  SinglePatientResponseModel.fromJson(Map<String, dynamic> json) {
    lead = json['lead'] != null ? new Lead.fromJson(json['lead']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lead != null) {
      data['lead'] = this.lead!.toJson();
    }
    return data;
  }
}

class Lead {
  int? id;
  String? name;
  String? phoneNumber;
  String? location;
  int? age;
  String? procedure;
  Source? source;
  List<SingleLeadSymtoms>? symptoms;
  Status? status;
  List<Logs>? logs;
  String? createdAt;
  String? updatedAt;

  Lead(
      {this.id,
        this.name,
        this.phoneNumber,
        this.location,
        this.age,
        this.procedure,
        this.source,
        this.symptoms,
        this.status,
        this.logs,
        this.createdAt,
        this.updatedAt});

  Lead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    location = json['location'];
    age = json['age'];
    procedure = json['procedure'] ?? "";
    source =
    json['source'] != null ? new Source.fromJson(json['source']) : null;
    if (json['symptoms'] != null) {
      symptoms = <SingleLeadSymtoms>[];
      json['symptoms'].forEach((v) {
        symptoms!.add(new SingleLeadSymtoms.fromJson(v));
      });
    }
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    if (json['logs'] != null) {
      logs = <Logs>[];
      json['logs'].forEach((v) {
        logs!.add(new Logs.fromJson(v));
      });
    }
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
    if (this.logs != null) {
      data['logs'] = this.logs!.map((v) => v.toJson()).toList();
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

class SingleLeadSymtoms {
  int? id;
  String? name;

  SingleLeadSymtoms({this.id, this.name});

  SingleLeadSymtoms.fromJson(Map<String, dynamic> json) {
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

class Logs {
  int? id;
  String? event;
  String? causer;
  Properties? properties;
  String? createdAt;
  String? updatedAt;

  Logs(
      {this.id,
        this.event,
        this.causer,
        this.properties,
        this.createdAt,
        this.updatedAt});

  Logs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    event = json['event'];
    causer = json['causer'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event'] = this.event;
    data['causer'] = this.causer;
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Properties {
  Attributes? attributes;
  Old? old;

  Properties({this.attributes, this.old});

  Properties.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
    old = json['old'] != null ? new Old.fromJson(json['old']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    if (this.old != null) {
      data['old'] = this.old!.toJson();
    }
    return data;
  }
}

class Attributes {
  String? note;
  String? status;
  String? procedure;
  int? sourceId;
  int? opNumber;

  Attributes(
      {this.note, this.status, this.procedure, this.sourceId, this.opNumber});

  Attributes.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    status = json['status'];
    procedure = json['procedure'];
    sourceId = json['source_id'];
    opNumber = json['op_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['status'] = this.status;
    data['procedure'] = this.procedure;
    data['source_id'] = this.sourceId;
    data['op_number'] = this.opNumber;
    return data;
  }
}

class Old {
  String? note;
  String? status;

  Old({this.note, this.status});

  Old.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['status'] = this.status;
    return data;
  }
}
