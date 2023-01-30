import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  TextEditingController searchField = TextEditingController();

  RxString title = "".obs;
  RxString subtitle = "".obs;
  RxList desc = [].obs;

  RxString submitData = "".obs;
  RxString notAdaData = "Tidak ada data".obs;
  RxBool isVisible = false.obs;

  searchKbbi() async {
    try {
      final response = await http.Client().get(Uri.parse(
          "https://kbbi-api-zhirrr.vercel.app/api/kbbi?text=${searchField.text}"));

      if (response.statusCode == 200) {
        var document = parse(response.body);
        var getDesc = document.getElementsByClassName("arti")[0].children;

        for (var i = 0; i < getDesc.length; i++) {
          title.value = getDesc[0].text.trim().split("bentuk tidak baku").first;
          subtitle.value = getDesc[0].text.trim().split("  ").last;
          desc.value.add(getDesc[1].children[i].text.trim());
        }
      }
    } on RangeError catch (e) {
      if (e.invalidValue == 0) {
        title.value = "Tidak ada data";
        subtitle.value;
        desc.value = [];
      }
    }
  }
}
