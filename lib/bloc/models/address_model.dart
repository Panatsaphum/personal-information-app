class AddressModel {
  AddressModel({
    this.nameEn,
    this.nameTh,
  });

  String? nameTh;
  String? nameEn;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        nameEn: json["name_en"],
        nameTh: json["name_th"],
      );

  Map<String, dynamic> toJson() => {
        "name_en": nameEn,
        "name_th": nameTh,
      };

  @override
  String toString() {
    return 'AddressModel{nameTh: $nameTh, nameEn: $nameEn}';
  }
}
