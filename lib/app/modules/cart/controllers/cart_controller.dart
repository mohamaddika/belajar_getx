import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../views/cart_output.dart';

class CartController extends GetxController {
   var namalengkap = ''.obs;
  var tempatlahir = ''.obs;
  var tanggallahir = ''.obs;
  var email = ''.obs;
  var negara = ''.obs;
  var nomorkartu = ''.obs;
  var tanggalExpired = ''.obs;
  var totalHarga = 0.0.obs;

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
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      tanggalExpired.value = formattedDate;
    }
  }

  void toggleMember(String memberValue) {
    selectedMember.value = memberValue;
    totalHarga.value = TotalHarga();
  }

  double TotalHarga() {
    if (selectedMember.value == 'Reguler') {
      return 50000.0;
    } else if (selectedMember.value == 'Gold') {
      return 150000.0;
    } else if (selectedMember.value == 'Platinum') {
      return 250000.0;
    } else if (selectedMember.value == 'VIP') {
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
