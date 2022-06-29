import 'package:latihan_sqlite/model/Pelanggan.dart';
import 'package:latihan_sqlite/screens/EditPelanggan.dart';
import 'package:latihan_sqlite/screens/addPelanggan.dart';
import 'package:latihan_sqlite/screens/viewPelanggan.dart';
import 'package:latihan_sqlite/services/pelangganService.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Pelanggan> _pelangganList = <Pelanggan>[];
  final _pelangganService = PelangganService();

  getAllPelangganDetails() async {
    var pelanggan = await _pelangganService.readAllPelanggan();
    _pelangganList = <Pelanggan>[];
    pelanggan.forEach((pelanggan) {
      setState(() {
        var pelangganModel = Pelanggan();
        pelangganModel.id_pelanggan = pelanggan['id_pelanggan'];
        pelangganModel.nama_pelanggan = pelanggan['nama_pelanggan'];
        pelangganModel.alamat = pelanggan['alamat'];
        pelangganModel.telepon = pelanggan['telepon'];
        pelangganModel.email = pelanggan['email'];
        _pelangganList.add(pelangganModel);
      });
    });
  }

  @override
  void initState() {
    getAllPelangganDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, pelangganId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure to Delete',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.red),
                  onPressed: () async {
                    var result =
                        await _pelangganService.deletePelanggan(pelangganId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllPelangganDetails();
                      _showSuccessSnackBar('Pelanggan Detail Deleted Success');
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite CRUD"),
      ),
      body: ListView.builder(
          itemCount: _pelangganList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewUser(
                                user: _pelangganList[index],
                              )));
                },
                leading: const Icon(Icons.person),
                title: Text(_pelangganList[index].nama_pelanggan ?? ''),
                subtitle: Text(_pelangganList[index].alamat ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditPelanggan(
                                        pelanggan: _pelangganList[index],
                                      ))).then((data) {
                            if (data != null) {
                              getAllPelangganDetails();
                              _showSuccessSnackBar(
                                  'Pelanggan Detail Updated Success');
                            }
                          });
                          ;
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.teal,
                        )),
                    IconButton(
                        onPressed: () {
                          _deleteFormDialog(
                              context, _pelangganList[index].id_pelanggan);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddPelanggan()))
              .then((data) {
            if (data != null) {
              getAllPelangganDetails();
              _showSuccessSnackBar('Pelanggan Detail Added Success');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
