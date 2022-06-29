import 'package:latihan_sqlite/model/Pelanggan.dart';
import 'package:latihan_sqlite/services/pelangganService.dart';
import 'package:flutter/material.dart';

class EditPelanggan extends StatefulWidget {
  final Pelanggan pelanggan;
  const EditPelanggan({Key? key, required this.pelanggan}) : super(key: key);

  @override
  State<EditPelanggan> createState() => _EditPelangganState();
}

class _EditPelangganState extends State<EditPelanggan> {
  var _pelangganNama_PelangganController = TextEditingController();
  var _pelangganAlamatController = TextEditingController();
  var _pelangganTeleponController = TextEditingController();
  var _pelangganEmailController = TextEditingController();
  bool _validateNama_Pelanggan = false;
  bool _validateAlamat = false;
  bool _validateTelepon = false;
  bool _validateEmail = false;
  var _pelangganService = PelangganService();

  @override
  void initState() {
    setState(() {
      _pelangganNama_PelangganController.text =
          widget.pelanggan.nama_pelanggan ?? '';
      _pelangganAlamatController.text = widget.pelanggan.alamat ?? '';
      _pelangganTeleponController.text = widget.pelanggan.telepon ?? '';
      _pelangganEmailController.text = widget.pelanggan.email ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite CRUD"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit New Pelanggan',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _pelangganNama_PelangganController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Nama_Pelanggan',
                    labelText: 'Nama_Pelanggan',
                    errorText: _validateNama_Pelanggan
                        ? 'Nama_Pelanggan Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _pelangganAlamatController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Alamat',
                    labelText: 'Alamat',
                    errorText:
                        _validateAlamat ? 'Alamat Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _pelangganTeleponController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Telepon',
                    labelText: 'Telepon',
                    errorText: _validateTelepon
                        ? 'Telepon Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _pelangganEmailController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Email',
                    labelText: 'Email',
                    errorText:
                        _validateEmail ? 'Email Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _pelangganNama_PelangganController.text.isEmpty
                              ? _validateNama_Pelanggan = true
                              : _validateNama_Pelanggan = false;
                          _pelangganAlamatController.text.isEmpty
                              ? _validateAlamat = true
                              : _validateAlamat = false;
                          _pelangganTeleponController.text.isEmpty
                              ? _validateTelepon = true
                              : _validateTelepon = false;
                          _pelangganEmailController.text.isEmpty
                              ? _validateEmail = true
                              : _validateEmail = false;
                        });
                        if (_validateNama_Pelanggan == false &&
                            _validateAlamat == false &&
                            _validateTelepon == false &&
                            _validateEmail == false) {
                          // print("Good Data Can Save");
                          var _pelanggan = Pelanggan();
                          _pelanggan.id_pelanggan =
                              widget.pelanggan.id_pelanggan;
                          _pelanggan.nama_pelanggan =
                              _pelangganNama_PelangganController.text;
                          _pelanggan.alamat = _pelangganAlamatController.text;
                          _pelanggan.telepon = _pelangganTeleponController.text;
                          _pelanggan.email = _pelangganEmailController.text;
                          var result = await _pelangganService.UpdatePelanggan(
                              _pelanggan);
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text('Update Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _pelangganNama_PelangganController.text = '';
                        _pelangganAlamatController.text = '';
                        _pelangganTeleponController.text = '';
                        _pelangganEmailController.text = '';
                      },
                      child: const Text('Clear Details'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
