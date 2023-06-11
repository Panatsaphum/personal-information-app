part of 'personal_information_bloc.dart';

@immutable
abstract class PersonalInformationEvent extends Equatable {
  const PersonalInformationEvent();

  List<Object> get props => [];
}

class GetAddess extends PersonalInformationEvent {}

class SaveInformation extends PersonalInformationEvent {
  const SaveInformation({
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
  final String? idNumber;
  final String? prefix;
  final String? name;
  final String? lastName;
  final DateTime? birthDate;
  final String? address;
  final String? subDistrict;
  final String? district;
  final String? province;
}
