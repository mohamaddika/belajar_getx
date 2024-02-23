class Pemilihan {
  int? id;
  String? namaPemilihan;
  String? deskripsi;
  String? status;
  String? createdAt;
  String? updatedAt;

  Pemilihan(
      {this.id,
      this.namaPemilihan,
      this.deskripsi,
      this.status,
      this.createdAt,
      this.updatedAt});

  Pemilihan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaPemilihan = json['nama_pemilihan'];
    deskripsi = json['deskripsi'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  set isEditable(bool isEditable) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_pemilihan'] = this.namaPemilihan;
    data['deskripsi'] = this.deskripsi;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}
