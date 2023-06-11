part of 'personal_information_bloc.dart';

enum PersonalInformationStatus { initial, loading, getDataSuccess, addressPage }

class PersonalInformationState {
  const PersonalInformationState._({
    required this.status,
    this.provinceData,
    this.districtData,
    this.subDistrictData,
    this.proVinceListEntry,
    this.districtListEntry,
    this.subDistrictListEntry,
    this.informationList,
  });

  const PersonalInformationState.initialized() : this._(status: PersonalInformationStatus.initial);

  const PersonalInformationState.personalInformation({
    PersonalInformationStatus status = PersonalInformationStatus.initial,
    List<AddressModel>? provinceData,
    List<AddressModel>? districtData,
    List<AddressModel>? subDistrictData,
    List<DropdownMenuEntry<String>>? proVinceListEntry,
    List<DropdownMenuEntry<String>>? districtListEntry,
    List<DropdownMenuEntry<String>>? subDistrictListEntry,
    List<InformationModel>? informationList,
  }) : this._(
          status: status,
          provinceData: provinceData,
          districtData: districtData,
          subDistrictData: subDistrictData,
          proVinceListEntry: proVinceListEntry,
          districtListEntry: districtListEntry,
          subDistrictListEntry: subDistrictListEntry,
          informationList: informationList,
        );

  final PersonalInformationStatus status;
  final List<AddressModel>? provinceData;
  final List<AddressModel>? districtData;
  final List<AddressModel>? subDistrictData;
  final List<DropdownMenuEntry<String>>? proVinceListEntry;
  final List<DropdownMenuEntry<String>>? districtListEntry;
  final List<DropdownMenuEntry<String>>? subDistrictListEntry;
  final List<InformationModel>? informationList;
}
