import 'dart:async';

import 'package:latihan_sqlite/db_helper/repository.dart';
import 'package:latihan_sqlite/model/Pelanggan.dart';

class PelangganService {
  late Repository _repository;
  PelangganService() {
    _repository = Repository();
  }
  //Save User
  SavePelanggan(Pelanggan pelanggan) async {
    return await _repository.insertData('pelanggan', pelanggan.pelangganMap());
  }

  //Read All Users
  readAllPelanggan() async {
    return await _repository.readData('pelanggan');
  }

  //Edit User
  UpdatePelanggan(Pelanggan pelanggan) async {
    return await _repository.updateData('pelanggan', pelanggan.pelangganMap());
  }

  deletePelanggan(pelangganId) async {
    return await _repository.deleteDataById('pelanggan', pelangganId);
  }
}
