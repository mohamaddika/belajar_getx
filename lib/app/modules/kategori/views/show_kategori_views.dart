// detail_pemilihan_view.dart
import 'package:flutter/material.dart';
import 'package:getx_belajar/app/data/models/kategori_model.dart';

class DetailPemilihanView extends StatelessWidget {
  final Pemilihan pemilihan;

  DetailPemilihanView({required this.pemilihan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pemilihan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${pemilihan.namaPemilihan}'),
            Text('Deskripsi: ${pemilihan.deskripsi}'),
            Text('Status: ${pemilihan.status}'),
          ],
        ),
      ),
    );
  }
}