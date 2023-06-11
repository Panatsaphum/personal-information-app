import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:personal_information_app/bloc/models/address_model.dart';
import 'package:personal_information_app/bloc/service/personal_Information_repo.dart';

part 'personal_information_event.dart';
part 'personal_information_state.dart';

class PersonalInformationBloc extends Bloc<PersonalInformationEvent, PersonalInformationState> {
  PersonalInformationBloc() : super(PersonalInformationState.initialized());

  @override
  Stream<PersonalInformationState> mapEventToState(PersonalInformationEvent event) async* {
    PersonalInformationService service = PersonalInformationService();
    if (event is GetAddess) {
      yield PersonalInformationState.personalInformation(status: PersonalInformationStatus.loading);
      List<AddressModel>? province = await service.getSProvince();
      List<AddressModel>? district = await service.getDistrict();
      List<AddressModel>? subDistrict = await service.getSubDistrict();
      yield PersonalInformationState.personalInformation(status: PersonalInformationStatus.getDataSuccess, provinceData: province, districtData: district, subDistrictData: subDistrict);
    }
  }
}
