import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfilView extends StatelessWidget {
  final ProfilController profilController = Get.put(ProfilController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => profilController.logout(),
          ),
        ],
      ),
      body: Obx(
        () => profilController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : profilController.user.isEmpty
                ? Center(child: Text('Tidak ada data profil'))
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID: ${profilController.user['id']}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Nama: ${profilController.user['name']}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Email: ${profilController.user['email']}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}

