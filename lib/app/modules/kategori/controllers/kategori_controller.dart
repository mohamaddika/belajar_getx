import 'dart:convert';

import 'package:getx_belajar/app/data/models/kategori_model.dart';
import 'package:getx_belajar/app/modules/kategori/views/show_kategori_views.dart';
import 'package:getx_belajar/app/providers/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:getx_belajar/app/routes/app_pages.dart';
import '../views/show_kategori_views.dart';

class KategoriController extends GetxController {
  var kategoriList = <Kategori>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var apiUrl = '${Api.baseUrl}/kategori';
      var headers = await Api.getHeaders();

      var response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body)['data']['data'];
        kategoriList
            .assignAll(jsonResponse.map((model) => Kategori.fromJson(model)));
      } else {
        throw Exception('Failed to load pasien');
      }
    } catch (e) {
      print('Error during fetching pasien: $e');
    }
  }

  //  fungsi create,
  Future<void> tambahKategori(
    String title,
  ) async {
    try {
      if (title.isEmpty) {
        Get.snackbar('Error', 'Semua field harus diisi');
        return;
      }

      var apiUrl = '${Api.baseUrl}/kategori';
      var headers = await Api.getHeaders();

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: {
          'title': title,
        },
      );

      if (response.statusCode == 201) {
        Get.snackbar('Sukses', 'Pasien berhasil ditambahkan');
        fetchData();
        Get.offAndToNamed(Routes.BOTTOM_MENU); // Redirect ke halaman pasien
      } else {
        throw Exception('Failed to add pasien');
      }
    } catch (e) {
      print('Error during tambah pasien: $e');
      if (e is http.Response) {
        print('Response Body: ${e.body}');
      }
    }
  }

  // edit pasien
  Future<void> editKategori(
    Kategori kategori,
    String title,
  ) async {
    try {
      if (title.isEmpty) {
        Get.snackbar('Error', 'Semua field harus diisi');
        return;
      }

      var apiUrl = '${Api.baseUrl}/kategori/${kategori.id}';
      var headers = await Api.getHeaders();

      var response = await http.put(
        Uri.parse(apiUrl),
        headers: headers,
        body: {
          'title': title,
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar('Sukses', 'Kategori berhasil diubah');
        fetchData(); // Refresh the kategoriList
        Get.offAndToNamed(Routes.BOTTOM_MENU);
      } else {
        throw Exception('Failed to edit pasien');
      }
    } catch (e) {
      print('Error during edit pasien: $e');
    }
  }

  // show pasien
    void showKategoriDetails(Kategori kategori) {
      Get.to(() => DetailKategoriView(kategori: kategori));
    }

    // delete pasien
  Future<void> deleteKategori(Kategori kategori) async {
    try {
      var apiUrl = '${Api.baseUrl}/kategori/${kategori.id}';
      var headers = await Api.getHeaders();

      var response = await http.delete(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Sukses', 'Kategori berhasil dihapus');
        fetchData();
        // Optionally, you can navigate to a different page after deletion
      } else {
        throw Exception('Failed to delete Kategori');
      }
    } catch (e) {
      print('Error during delete Kategori: $e');
    }
  }

}
