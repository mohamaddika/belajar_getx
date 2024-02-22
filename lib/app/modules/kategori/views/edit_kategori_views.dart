// edit_pasien_view.dart
import 'package:getx_belajar/app/data/models/kategori_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kategori_controller.dart';

class EditPemilihanView extends StatelessWidget {
  final Pemilihan pemilihan;
  final PemilihanController controller = Get.find();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  EditPemilihanView({required this.pemilihan}) {
    namaController.text = pemilihan.namaPemilihan!;
    deskripsiController.text = pemilihan.deskripsi!;
    statusController.text = pemilihan.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pemilihan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextFormField(
              controller: deskripsiController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextFormField(
              controller: statusController,
              decoration: InputDecoration(labelText: 'Status'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_validateInput()) {
                  // Always call the editPasien method without any conditional checks
                  controller.EditPemilihanView(
                    pemilihan,
                    namaController.text,
                    deskripsiController.text,
                    statusController.text,
                  );
                }
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateInput() {
    if (namaController.text.isEmpty ||
        deskripsiController.text.isEmpty ||
        statusController.text.isEmpty) {
      Get.snackbar('Error', 'Semua field harus diisi');
      return false;
    }
    return true;
  }
}
