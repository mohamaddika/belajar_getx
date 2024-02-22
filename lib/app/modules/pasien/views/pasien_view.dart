// pasien_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_belajar/app/data/models/pasien_model.dart';
import '../controllers/pasien_controller.dart';

class PasienView extends StatelessWidget {
  final PasienController controller = Get.put(PasienController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pasien'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed('/tambah-pasien');
            },
          ),
        ],
      ),
      body: Obx(
        () => controller.pasienList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.pasienList.length,
                itemBuilder: (context, index) {
                  var pasien = controller.pasienList[index];
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(pasien.nama),
                        ),
                        // IconButton(
                        //   icon: Icon(Icons.edit),
                        //   onPressed: () {
                        //     Get.to(() => EditPasienView(pasien: pasien));
                        //   },
                        // ),
                        // IconButton(
                        //   icon: Icon(Icons.visibility),
                        //   onPressed: () {
                        //     Get.to(() => DetailPasienView(pasien: pasien));
                        //   },
                        // ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Show a confirmation dialog before deleting
                            showDeleteConfirmation(context, pasien);
                          },
                        ),
                      ],
                    ),
                    subtitle: Text(pasien.jenisKelamin),
                    onTap: () {
                      // Pass the 'isEditable' flag to indicate whether it's for editing or viewing
                      pasien.isEditable =
                          true; // Set to false for 'Lihat Detail'
                      // controller.showPasienDetails(pasien);
                    },
                  );
                },
              ),
      ),
    );
  }

  void showDeleteConfirmation(BuildContext context, Pasien pasien) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Pasien'),
          content: Text('Are you sure you want to delete ${pasien.nama}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Call the deletePasien method from the controller
                controller.deletePasien(pasien);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
