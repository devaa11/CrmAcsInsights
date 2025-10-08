class CreatePatientResponseModel {
  final Patient? patient;
  final String? message;

  CreatePatientResponseModel({this.patient, this.message});

  factory CreatePatientResponseModel.fromJson(Map<String, dynamic> json) {
    return CreatePatientResponseModel(
      patient: json['lead'] != null ? Patient.fromJson(json['lead']) : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lead': patient?.toJson(),
      'message': message,
    };
  }
}

class Patient {
  final int? id;
  final String? name;
  final String? phoneNumber;
  final String? location;
  final int? age;
  final String? company_name;
  final Source? source;
  final List<Symptom>? symptoms;
  final Status? status;
  final String? createdAt;
  final String? updatedAt;

  Patient({
    this.id,
    this.name,
    this.phoneNumber,
    this.location,
    this.company_name,
    this.age,
    this.source,
    this.symptoms,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      location: json['location'],
      age: json['age'],
      company_name: json['company_name'],
      source: json['source'] != null ? Source.fromJson(json['source']) : null,
      symptoms: (json['symptoms'] as List<dynamic>?)
          ?.map((e) => Symptom.fromJson(e))
          .toList(),
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'location': location,
      'age': age,
      'source': source?.toJson(),
      'symptoms': symptoms?.map((e) => e.toJson()).toList(),
      'status': status?.toJson(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Source {
  final int? id;
  final String? name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class Symptom {
  final int? id;
  final String? name;

  Symptom({this.id, this.name});

  factory Symptom.fromJson(Map<String, dynamic> json) {
    return Symptom(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class Status {
  final String? id;
  final String? name;
  final String? color;

  Status({this.id, this.name, this.color});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id']?.toString(),
      name: json['name'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'color': color,
  };
}
