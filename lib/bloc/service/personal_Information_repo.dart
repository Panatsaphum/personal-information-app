import 'dart:convert';
import 'package:personal_information_app/bloc/models/address_model.dart';
import 'package:http/http.dart' as http;

class PersonalInformationService {
  Future<List<AddressModel>> getSProvince() async {
    try {
      Uri url = Uri.parse("https://raw.githubusercontent.com/kongvut/thai-province-data/master/api_province.json");
      var res = await http.get(url);
      List<dynamic>? resList = jsonDecode(res.body);
      List<AddressModel>? province = resList?.map((e) => AddressModel.fromJson(e)).toList();
      return province ?? [];
    } catch (e) {
      return [];
    }
  }
}
