// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class Data
{
  List<Welcome>? data;
  Data({
    this.data,
    });

  factory Data.fromJSON(List d) => Data(
      data: List<Welcome>.from(d.map((x) => Welcome.fromJson(x)))
  );
}

class Welcome {
  Welcome({
    this.rowId,
    this.kMedId,
    this.firstName,
    this.lastName,
    this.gender,
    this.contactDetail,
  });

  int? rowId;
  String? kMedId;
  String? firstName;
  String? lastName;
  String? gender;
  ContactDetail? contactDetail;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    rowId: json["row_Id"],
    kMedId: json["kMedId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    gender: json["gender"],
    contactDetail: ContactDetail.fromJson(json["contactDetail"]),
  );

  Map<String, dynamic> toJson() => {
    "row_Id": rowId,
    "kMedId": kMedId,
    "firstName": firstName,
    "lastName": lastName,
    "gender": gender,
    "contactDetail": contactDetail!.toJson(),
  };
}

class ContactDetail {
  ContactDetail({
    this.rowId,
    this.mobileNo,
    this.address,
  });

  int? rowId;
  double? mobileNo;
  String? address;

  factory ContactDetail.fromJson(Map<String, dynamic> json) => ContactDetail(
    rowId: json["row_ID"],
    mobileNo: json["mobile_No"].toDouble(),
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "row_ID": rowId,
    "mobile_No": mobileNo,
    "address": address,
  };
}
