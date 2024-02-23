import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_belajar/app/data/models/kategori_model.dart';
import 'package:getx_belajar/app/modules/kategori/views/create_kategori_views.dart';
import 'package:getx_belajar/app/modules/kategori/views/edit_kategori_views.dart';
import 'package:getx_belajar/app/modules/kategori/views/show_kategori_views.dart';
import '../controllers/kategori_controller.dart';

class PemilihanView extends StatelessWidget {
  final PemilihanController controller = Get.put(PemilihanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pemilihan'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(TambahPemilihanView());
              // Get.toNamed('/tambah-pemilihan');
            },
          ),
        ],
      ),
      body: Obx(
        () => controller.pemilihanList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.pemilihanList.length,
                itemBuilder: (context, index) {
                  var pemilihan = controller.pemilihanList[index];
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(pemilihan.namaPemilihan.toString()),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Get.to(
                                () => EditPemilihanView(pemilihan: pemilihan));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.visibility),
                          onPressed: () {
                            Get.to(() =>
                                DetailPemilihanView(pemilihan: pemilihan));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Show a confirmation dialog before deleting
                            showDeleteConfirmation(context, pemilihan);
                          },
                        ),
                      ],
                    ),
                    subtitle: Text(pemilihan.deskripsi.toString()),
                    onTap: () {
                      // Pass the 'isEditable' flag to indicate whether it's for editing or viewing
                      pemilihan.isEditable =
                          true; // Set to false for 'Lihat Detail'
                      controller.showPemilihanDetails(pemilihan);
                    },
                  );
                },
              ),
      ),
    );
  }

  void showDeleteConfirmation(BuildContext context, Pemilihan pemilihan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete pemilihan'),
          content: Text(
              'Are you sure you want to delete ${pemilihan.namaPemilihan}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Call the deletepemilihan method from the controller
                controller.deletePemilihan(pemilihan);
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
