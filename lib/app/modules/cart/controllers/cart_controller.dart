import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../views/cart_output.dart';

class CartController extends GetxController {
  var namalengkap = ''.obs;
  var tempatlahir = ''.obs;
  var tanggallahir = ''.obs;
  var jeniskelamin = ''.obs;
  var email = ''.obs;
  var negara = ''.obs;
  var nomorkartu = ''.obs;
  var tanggalExpired = ''.obs;
  var age = ''.obs;
  var totalHarga = 0.0.obs;
  var benefit = ''.obs;

  final List<String> memberList = [
    'Reguler',
    'Gold',
    'Platinum',
    'VIP',
  ];

  var selectedMember = ''.obs;

  List<String> getMemberList() => memberList;

  var isFormSubmitted = false.obs;
  var selectedDate = ''.obs;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      selectedDate.value = formattedDate;

      final birthDate = picked;
      final currentDate = DateTime.now();
      final ageValue = currentDate.year -
          birthDate.year +
          (currentDate.month > birthDate.month ||
                  (currentDate.month == birthDate.month &&
                      currentDate.day >= birthDate.day)
              ? 0
              : -1);
      // Set nilai umur
      age.value = ageValue.toString();
    }
  }

  Future<void> expiredDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final expiredDate = picked.add(Duration(days: 7));

      final formattedDate = DateFormat('yyyy-MM-dd').format(expiredDate);
      tanggalExpired.value = formattedDate;
    }
  }

  void toggleMember(String memberValue) {
    selectedMember.value = memberValue;
    totalHarga.value = TotalHarga();
  }

  double TotalHarga() {
    if (selectedMember.value == 'Reguler') {
      benefit.value = 'Anggota 1 bulan';
      return 50000.0;
    } else if (selectedMember.value == 'Gold') {
       benefit.value = 'Anggota 1 bulan + Cemilan';
      return 150000.0;
    } else if (selectedMember.value == 'Platinum') {
       benefit.value = 'Anggota 2 bulan + Cemilan + Wifi';
      return 250000.0;
    } else if (selectedMember.value == 'VIP') {
       benefit.value = 'Anggota 3 bulan + Cemilan + Wifi + Tiket Konser';
      return 500000.0;
    } else {
      return 0.0;
    }
  }

  void submitForm() {
    print(
        'Data Formulir: $namalengkap, $tempatlahir, $tanggallahir, $email, $negara, ${selectedMember.value}, Total Harga: ${totalHarga.value}, $nomorkartu, $tanggalExpired');
    isFormSubmitted.value = true;
    Get.to(cartOutput());
  }
}
