
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_belajar/app/modules/home/views/home_view.dart';
import 'package:getx_belajar/app/modules/kategori/views/kategori_view.dart';
import 'package:getx_belajar/app/modules/profile/views/profile_view.dart';

import '../controllers/bottom_menu_controller.dart';

class BottomMenuView extends GetView<BottomMenuController> {
  const BottomMenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: [HomeView(), PemilihanView(), ProfileView()],
          )),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.changePage(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'produk',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
