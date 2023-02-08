import 'package:com_kbbisuperapp/app/modules/home/controllers/home_controller.dart';
import 'package:com_kbbisuperapp/app/widgets/about_application.dart';
import 'package:com_kbbisuperapp/app/widgets/search_keyword_widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  AboutApp aboutApp = AboutApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(microseconds: 1)),
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
                      const Image(
                        image: AssetImage("assets/books.png"),
                        height: 300,
                        width: 300,
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        "Kamus Besar Bahasa Indonesia (Online)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 80),
                      LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white, size: 50),
                    ],
                  ),
                  const Text(
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
              title: const Text("KBBI Online"),
              centerTitle: true,
              backgroundColor: Colors.red[400],
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    aboutApp.aboutApp();
                  },
                  icon: const Icon(
                    Icons.info_outline_rounded,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                SearchKeyword(controller: controller),
                const SizedBox(height: 20),
                Obx(
                  () => Visibility(
                    visible: controller.isVisible.value,
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.find_in_page),
                              SizedBox(width: 3),
                              Text(
                                "Hasil Pencarian",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          controller.title.value == ""
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  child: const Center(
                                      child: Text(
                                    "Loading...",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                        controller.title.value.trim(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        controller
                                            .subtitle.value.capitalizeFirst
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      const SizedBox(height: 10),
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
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
                                              backgroundColor: Colors.red[400],
                                              child: Text(
                                                "${index + 1}",
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            subtitle: Text.rich(
                                              TextSpan(
                                                text: controller.desc[index]
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                children: [
                                                  const TextSpan(text: " "),
                                                  TextSpan(
                                                    text:
                                                        " ${controller.desc[index].toString().split('  ').last}",
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
