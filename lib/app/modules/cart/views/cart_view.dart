import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/cart_controller.dart';

class CartView extends StatelessWidget {
  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latihan Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Lengkap'),
                onChanged: (value) => controller.namalengkap.value = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tempat Lahir'),
                onChanged: (value) => controller.tempatlahir.value = value,
              ),
              Obx(
                () => TextFormField(
                  decoration: InputDecoration(labelText: 'Tanggal Lahir'),
                  readOnly: true,
                  controller: TextEditingController(
                      text: controller.selectedDate.value),
                  onTap: () => controller.selectDate(context),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) => controller.email.value = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Negara'),
                onChanged: (value) => controller.negara.value = value,
              ),
              SizedBox(height: 16),
              Text('Pilih Jenis Member:'),
              Obx(
                () => Wrap(
                  children: controller.memberList.map((memberType) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FilterChip(
                        label: Text(memberType),
                        selected: controller.selectedMember.value == memberType,
                        onSelected: (selected) =>
                            controller.toggleMember(memberType),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nomor Kartu'),
                onChanged: (value) => controller.nomorkartu.value = value,
              ),
              Obx(() => TextFormField(
                    decoration: InputDecoration(labelText: 'Tanggal Expired'),
                    readOnly: true,
                    controller: TextEditingController(
                        text: controller.tanggalExpired.value),
                    onTap: () => controller.expiredDate(context),
                  )),
              SizedBox(height: 16),
              Text('Payment:'),
              Obx(
                () => Text(
                  'Harga Member: ${controller.totalHarga.value}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => controller.submitForm(),
                child: Text('Submit'),
              ),
              Obx(
                () => controller.isFormSubmitted.value
                    ? Text('Formulir sudah disubmit!')
                    : SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
