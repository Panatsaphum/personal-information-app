part of 'personal_information_bloc.dart';

enum PersonalInformationStatus {
  initial,
  loading,
  getDataSuccess,
}

class PersonalInformationState {
  const PersonalInformationState._({
    required this.status,
    this.provinceData,
    this.districtData,
    this.subDistrictData,
  });

  const PersonalInformationState.initialized() : this._(status: PersonalInformationStatus.initial);

  const PersonalInformationState.personalInformation({
    PersonalInformationStatus status = PersonalInformationStatus.initial,
    List<AddressModel>? provinceData,
    List<AddressModel>? districtData,
    List<AddressModel>? subDistrictData,
  }) : this._(
          status: status,
          provinceData: provinceData,
          districtData: districtData,
          subDistrictData: subDistrictData,
        );

  final PersonalInformationStatus status;
  final List<AddressModel>? provinceData;
  final List<AddressModel>? districtData;
  final List<AddressModel>? subDistrictData;
}
