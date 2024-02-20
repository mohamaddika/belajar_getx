import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BiodataController extends GetxController {
  var nama = ''.obs;
  var tanggalLahir = ''.obs;
  var agama = ''.obs;
  var jenisKelamin = ''.obs;
  var alamat = ''.obs;
  final List<String> hobiList = [
    'Menari',
    'Membaca',
    'Bernyanyi',
    'Berenang',
    'Sepak Bola'
  ];
  var hobi = <String>[].obs;
  var isFormSubmitted = false.obs;
  var selectedDate = ''.obs;

  List<String> getHobiList() => hobiList;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      selectedDate.value = formattedDate; // simpan tanggal dipilih
    }
  }

  void toggleHobi(String hobiValue) {
    if (hobi.contains(hobiValue)) {
      hobi.remove(hobiValue);
    } else {
      hobi.add(hobiValue);
    }
  }

  void submitForm() {
    print(
        'Data Formulir: ${nama.value}, ${tanggalLahir.value}, ${agama.value}, ${jenisKelamin.value}, ${alamat.value}, ${hobi.value}');
    isFormSubmitted.value = true;
  }
}
