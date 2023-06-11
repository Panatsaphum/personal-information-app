import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:personal_information_app/bloc/models/address_model.dart';
import 'package:personal_information_app/bloc/models/information_model.dart';
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

      List<DropdownMenuEntry<String>> proVinceListEntry = [];

      for (int i = 0; i < province.length; i++) {
        proVinceListEntry.add(
          DropdownMenuEntry(
            value: province[i].nameTh ?? "",
            label: province[i].nameTh ?? "",
          ),
        );
      }

      yield PersonalInformationState.personalInformation(
        status: PersonalInformationStatus.getDataSuccess,
        provinceData: province,
        proVinceListEntry: proVinceListEntry,
      );
    }

    if (event is SaveInformation) {
      List<InformationModel>? info = state.informationList ?? [];
      info.add(
        InformationModel(
          idNumber: event.idNumber,
          prefix: event.prefix,
          name: event.name,
          lastName: event.lastName,
          birthDate: event.birthDate,
          address: event.address,
          subDistrict: event.subDistrict,
          district: event.district,
          province: event.province,
        ),
      );
      yield PersonalInformationState.personalInformation(informationList: info, proVinceListEntry: state.proVinceListEntry);
    }
  }
}
