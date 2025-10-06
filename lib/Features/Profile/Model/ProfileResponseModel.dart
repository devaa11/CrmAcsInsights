class ProfileResponseModel {
  User? user;

  ProfileResponseModel({this.user});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phoneNo;
  String? imageUrl;
  int? totalLeads;
  PieChartData? pieChartData;
  String? role;
  String? lastLoginAt;
  String? createdAt;

  User(
      {this.id,
        this.name,
        this.email,
        this.phoneNo,
        this.imageUrl,
        this.totalLeads,
         this.pieChartData,
        this.role,
        this.lastLoginAt,
        this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    imageUrl = json['image_url'];
    totalLeads = json['total_leads'];
    pieChartData = json['pie_chart'] != null
        ? new PieChartData.fromJson(json['pie_chart'])
        : null;
    role = json['role'];
    lastLoginAt = json['last_login_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['image_url'] = this.imageUrl;
    data['total_leads'] = this.totalLeads;
    data['role'] = this.role;
    data['last_login_at'] = this.lastLoginAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class PieChartData {
  int? newCall;
  int? followUp;
  int? interested;

  PieChartData(this.newCall, this.followUp, this.interested);

  PieChartData.fromJson(Map<String, dynamic> json) {
    newCall = json['new_call'] is int ? json['new_call'] : 0;
    followUp = json['follow_up'] is int ? json['follow_up'] : 0;
    interested = json['interested'] is int ? json['interested'] : 0;
  }
}
