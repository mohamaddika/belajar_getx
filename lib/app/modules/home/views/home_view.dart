import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_belajar/app/modules/profile/views/profile_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/profile');
              },
              child: Text("Halaman Profil"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/counter');
              },
              child: Text("Halaman Counter"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/biodata');
              },
              child: Text("Halaman Biodata"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/cart');
              },
              child: Text("Halaman invoice"),
            ),
             ElevatedButton(
              onPressed: () {
                Get.toNamed('/login');
              },
              child: Text("Halaman Login"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/kategori');
              },
              child: Text("Halaman Kategori"),
            )
          ],
        ),
      ),
    );
  }
}
