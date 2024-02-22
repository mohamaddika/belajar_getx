import 'dart:convert';
import 'package:getx_belajar/app/data/models/kategori_model.dart';
import 'package:getx_belajar/app/modules/kategori/views/edit_kategori_views.dart';
import 'package:getx_belajar/app/modules/kategori/views/show_kategori_views.dart';
import 'package:getx_belajar/app/providers/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:getx_belajar/app/routes/app_pages.dart';

class PemilihanController extends GetxController {
  var pemilihanList = <Pemilihan>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var apiUrl = '${Api.baseUrl}/pemilihan';
      var headers = await Api.getHeaders();

      var response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body);
        pemilihanList
            .assignAll(jsonResponse.map((model) => Pemilihan.fromJson(model)));
      } else {
        throw Exception('Failed to load pemilihan');
      }
    } catch (e) {
      print('Error during fetching pemilihan: $e');
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

  void deletepemilihan(Pemilihan pemilihan) {}

  void tambahPemilihan(String text, String value, String text2) {}

  // edit pasien
  Future<void> EditPemilihanView(
    Pemilihan pemilihan,
    String title, String text, [String? text1]
  ) async {
    try {
      if (title.isEmpty) {
        Get.snackbar('Error', 'Semua field harus diisi');
        return;
      }

      var apiUrl = '${Api.baseUrl}/kategori/${pemilihan.id}';
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
        fetchData(); // Refresh the pemilihanList
        Get.offAndToNamed(Routes.BOTTOM_MENU);
      } else {
        throw Exception('Failed to edit pemilihan');
      }
    } catch (e) {
      print('Error during edit pasien: $e');
    }
  }

  // show pasien
  void showKategoriDetails(Pemilihan pemilihan) {
    Get.to(() => DetailPemilihanView(pemilihan: pemilihan));
  }

  // delete pasien
  Future<void> deletePemilihan(Pemilihan pemilihan) async {
    try {
      var apiUrl = '${Api.baseUrl}/kategori/${pemilihan.id}';
      var headers = await Api.getHeaders();

      var response = await http.delete(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Sukses', 'Pemilihan berhasil dihapus');
        fetchData();
        // Optionally, you can navigate to a different page after deletion
      } else {
        throw Exception('Failed to delete Pemilihan');
      }
    } catch (e) {
      print('Error during delete Pemilihan: $e');
    }
  }
}
