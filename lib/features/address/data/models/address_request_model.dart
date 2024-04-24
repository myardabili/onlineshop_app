import 'dart:convert';

class AddressRequestModel {
  final String? name;
  final String? fullAddress;
  final String? phone;
  final String? provId;
  final String? cityId;
  final String? subdistrictId;
  final String? postalCode;
  final int? isDefault;

  AddressRequestModel({
    this.name,
    this.fullAddress,
    this.phone,
    this.provId,
    this.cityId,
    this.subdistrictId,
    this.postalCode,
    this.isDefault,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'full_address': fullAddress,
      'phone': phone,
      'prov_id': provId,
      'city_id': cityId,
      'district_id': subdistrictId,
      'postal_code': postalCode,
      'is_default': isDefault,
    };
  }

  factory AddressRequestModel.fromMap(Map<String, dynamic> map) {
    return AddressRequestModel(
      name: map['name'] != null ? map['name'] as String : null,
      fullAddress:
          map['fullAddress'] != null ? map['fullAddress'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      provId: map['provId'] != null ? map['provId'] as String : null,
      cityId: map['cityId'] != null ? map['cityId'] as String : null,
      subdistrictId:
          map['districtId'] != null ? map['districtId'] as String : null,
      postalCode:
          map['postalCode'] != null ? map['postalCode'] as String : null,
      isDefault: map['isDefault'] != null ? map['isDefault'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressRequestModel.fromJson(String source) =>
      AddressRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
