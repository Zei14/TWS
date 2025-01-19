import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class KataKataPage extends StatefulWidget {
  const KataKataPage({super.key});

  @override
  _KataKataPageState createState() => _KataKataPageState();
}

class _KataKataPageState extends State<KataKataPage> {
  List<String> kataKata = [];
  final TextEditingController _controller = TextEditingController();

  void _tambahKataKata() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        kataKata.add(_controller.text);
        _controller.clear();
      });
    }
  }

  void _editKataKata(int index) {
    _controller.text = kataKata[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Kata-Kata'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: "Masukkan kata-kata"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  kataKata[index] = _controller.text;
                  _controller.clear();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  void _hapusKataKata(int index) {
    setState(() {
      kataKata.removeAt(index);
    });
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(
        context, '/login'); // Arahkan kembali ke halaman login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kata-Kata Hari Ini',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.blue, // Mengubah AppBar menjadi warna biru
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout, // Panggil fungsi logout saat tombol ditekan
            iconSize: 30,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Tambah Kata-Kata',
                labelStyle: const TextStyle(
                    color: Colors.blue), // Ganti warna label jadi biru
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Border rounded
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: Colors.blue, width: 2), // Fokus border biru
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add,
                      color: Colors.blue), // Ganti warna ikon tambah jadi biru
                  onPressed: _tambahKataKata,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: kataKata.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                        color: Colors.blue.withOpacity(0.5),
                        width: 1), // Ganti border card jadi biru
                  ),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    title: Text(
                      kataKata[index],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit,
                              color: Colors.blue), // Ganti ikon edit jadi biru
                          onPressed: () => _editKataKata(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _hapusKataKata(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
