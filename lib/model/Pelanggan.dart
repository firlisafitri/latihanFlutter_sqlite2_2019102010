class Pelanggan {
  int? id_pelanggan;
  String? nama_pelanggan;
  String? alamat;
  String? telepon;
  String? email;

  pelangganMap() {
    var mapping = Map<String, dynamic>();
    mapping['id_pelanggan'] = id_pelanggan ?? null;
    mapping['nama_pelanggan'] = nama_pelanggan!;
    mapping['alamat'] = alamat!;
    mapping['telepon'] = telepon!;
    mapping['email'] = email!;
    return mapping;
  }
}
