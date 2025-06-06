import 'dart:convert';

class Buyerprofilerequestmodel {
  final String? name;
  final String? address;
  final String? phone;
  final dynamic photo;

  Buyerprofilerequestmodel({this.name, this.address, this.phone, this.photo});

  factory Buyerprofilerequestmodel.fromJson(String str) =>
      Buyerprofilerequestmodel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Buyerprofilerequestmodel.fromMap(Map<String, dynamic> json) =>
      Buyerprofilerequestmodel(
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        photo: json["photo"],
      );

  Map<String, dynamic> toMap() => {
    "name": name,
    "address": address,
    "phone": phone,
    "photo": photo,
  };
}
