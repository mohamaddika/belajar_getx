import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_belajar/app/data/models/kategori_model.dart';
import 'package:getx_belajar/app/modules/kategori/views/create_kategori_views.dart';
import '../../pasien/views/edit_kategori_views.dart';
import '../../pasien/views/show_kategori_views.dart';
import '../controllers/kategori_controller.dart';

class KategoriView extends StatelessWidget {
  final KategoriController controller = Get.put(KategoriController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Kategori'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(() => TambahKategoriView());
            },
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.kategoriList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            // Print data dari API kategori sebelum menampilkan dalam ListView
            for (var kategori in controller.kategoriList) {
              print('Kategori: ${kategori.title}');
            }

            return ListView.builder(
              itemCount: controller.kategoriList.length,
              itemBuilder: (context, index) {
                var kategori = controller.kategoriList[index];
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(kategori.title),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Get.to(() => EditKategoriView(kategori: kategori));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          Get.to(() => DetailKategoriView(kategori: kategori));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDeleteConfirmation(context, kategori);
                        },
                      ),
                    ],
                  ),
                  onTap: () {

                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void showDeleteConfirmation(BuildContext context, Kategori kategori) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Pasien'),
          content: Text('Are you sure you want to delete ${kategori.title}?'),
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
                controller.deleteKategori(kategori);
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
