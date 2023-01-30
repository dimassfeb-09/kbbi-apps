import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(microseconds: 1)),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.red[400],
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Image(
                        image: AssetImage("assets/books.png"),
                        height: 300,
                        width: 300,
                      ),
                      SizedBox(height: 50),
                      Text(
                        "Kamus Besar Bahasa Indonesia (Online)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 80),
                      LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white, size: 50),
                    ],
                  ),
                  Text(
                    "Versi Aplikasi 1.0",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text("KBBI Online"),
              centerTitle: true,
              backgroundColor: Colors.red[400],
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Tentang Aplikasi",
                      content: Container(
                        height: 130,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Versi Aplikasi"),
                                Text("1.0"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Credit Icon"),
                                GestureDetector(
                                  onTap: () async {
                                    Uri url = Uri.parse(
                                        "https://www.flaticon.com/premium-icon/books_2847502?term=book&page=1&position=27&page=1&position=27&related_id=2847502&origin=search");
                                    launchUrl(url);
                                  },
                                  child: Row(
                                    children: [
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
                                Text("Sumber Data KBBI"),
                                GestureDetector(
                                  onTap: () async {
                                    Uri url = Uri.parse(
                                        "http://kbbi.kamus.pelajar.id/");
                                    launchUrl(url);
                                  },
                                  child: Row(
                                    children: [
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
                  },
                  icon: Icon(
                    Icons.info_outline_rounded,
                    size: 30,
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
            body: ListView(
              padding: EdgeInsets.all(20),
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    onTap: () {
                      controller.title.value = '';
                      controller.desc.value.clear();
                      controller.subtitle.value = '';
                      controller.isVisible.value = false;
                    },
                    controller: controller.searchField,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: 'Cari Kata',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      suffix: InkWell(
                        onTap: () {
                          controller.searchField.text =
                              controller.submitData.value;
                          controller.searchKbbi();
                          controller.isVisible.value = true;
                        },
                        child: Ink(
                          color: Colors.white,
                          padding: EdgeInsets.only(right: 10),
                          child: Text("Search"),
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
                ),
                SizedBox(height: 20),
                Obx(
                  () => Visibility(
                    visible: controller.isVisible.value,
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.find_in_page),
                              SizedBox(width: 3),
                              Text(
                                "Hasil Pencarian",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  controller.title.value.trim(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  controller.subtitle.value.capitalizeFirst
                                      .toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 10),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.desc.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      leading: CircleAvatar(
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.red[400],
                                      ),
                                      subtitle: Text.rich(
                                        TextSpan(
                                          text: controller.desc.value[index]
                                              .toString()
                                              .split('  ')
                                              .first,
                                          style:
                                              TextStyle(color: Colors.red[400]),
                                          children: [
                                            TextSpan(text: " "),
                                            TextSpan(
                                              text:
                                                  " ${controller.desc.value[index].toString().split('  ').last}",
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
