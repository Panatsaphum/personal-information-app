class InformationModel {
  InformationModel({
    this.idNumber,
    this.prefix,
    this.name,
    this.lastName,
    this.birthDate,
    this.address,
    this.subDistrict,
    this.district,
    this.province,
  });

  String? idNumber;
  String? prefix;
  String? name;
  String? lastName;
  DateTime? birthDate;
  String? address;
  String? subDistrict;
  String? district;
  String? province;

  @override
  String toString() {
    return 'InformationModel{idNumber: $idNumber, prefix: $prefix, name: $name, lastName: $lastName, birthDate: $birthDate, address: $address, subDistrict: $subDistrict, district: $district, province: $province}';
  }
}
