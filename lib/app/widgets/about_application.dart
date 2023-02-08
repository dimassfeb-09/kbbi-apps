import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutApp {
  Future<dynamic> aboutApp() {
    return Get.defaultDialog(
      title: "Tentang Aplikasi",
      content: Container(
        height: 130,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Versi Aplikasi"),
                Text("1.0"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Credit Icon"),
                GestureDetector(
                  onTap: () async {
                    Uri url = Uri.parse(
                        "https://www.flaticon.com/premium-icon/books_2847502?term=book&page=1&position=27&page=1&position=27&related_id=2847502&origin=search");
                    launchUrl(url);
                  },
                  child: Row(
                    children: const [
                      Text("Open"),
                      SizedBox(width: 5),
                      Icon(Icons.open_in_new),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Sumber Data KBBI"),
                GestureDetector(
                  onTap: () async {
                    Uri url = Uri.parse("http://kbbi.kamus.pelajar.id/");
                    launchUrl(url);
                  },
                  child: Row(
                    children: const [
                      Text("Open"),
                      SizedBox(width: 5),
                      Icon(Icons.open_in_new),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
