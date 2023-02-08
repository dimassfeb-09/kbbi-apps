import 'package:com_kbbisuperapp/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class SearchKeyword extends StatelessWidget {
  const SearchKeyword({super.key, required this.controller, required});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.red[400],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        keyboardType: TextInputType.text,
        onTap: () {
          controller.title.value = '';
          controller.desc.clear();
          controller.subtitle.value = '';
          controller.isVisible.value = false;
        },
        controller: controller.searchField,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          hintText: 'Cari Kata',
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          suffix: InkWell(
            onTap: () {
              controller.searchField.text = controller.submitData.value;
              controller.searchKbbi();
              controller.isVisible.value = true;
            },
            child: Ink(
              color: Colors.white,
              padding: const EdgeInsets.only(right: 10),
              child: const Text("Search"),
            ),
          ),
        ),
        onChanged: (value) {
          controller.submitData.value = value;
        },
        onSubmitted: (value) {
          controller.searchField.text = value;
          controller.searchKbbi();
          controller.isVisible.value = true;
        },
      ),
    );
  }
}
