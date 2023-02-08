import 'dart:convert';

import 'package:com_kbbisuperapp/app/modules/home/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  TextEditingController searchField = TextEditingController();

  RxString title = "".obs;
  RxString subtitle = "".obs;
  RxList desc = [].obs;

  RxString submitData = "".obs;
  RxString notAdaData = "Tidak ada data".obs;
  RxBool isVisible = false.obs;

  void searchKbbi() async {
    try {
      final response = await http.Client().get(Uri.parse(
          "https://kbbi-api-zhirrr.vercel.app/api/kbbi?text=${searchField.text}"));

      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
        KBBIModel kbbi = KBBIModel.fromJson(result);

        if (title.value != "" && desc != []) {
          title.value = "";
          desc.value = [];
        }

        title.value = kbbi.title;
        for (var i = 0; i < kbbi.desc.length; i++) {
          desc.add(kbbi.desc[i]);
        }
      } else if (response.statusCode >= 400) {
        title.value = "Data tidak ditemukan";
      }
    } catch (e) {
      return;
    }
  }
}
