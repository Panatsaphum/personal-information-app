part of 'personal_information_bloc.dart';

@immutable
abstract class PersonalInformationEvent extends Equatable {
  const PersonalInformationEvent();

  List<Object> get props => [];
}

class GetAddess extends PersonalInformationEvent {}
