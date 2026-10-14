import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pengajuan_model.dart';

class RincianLayananPage extends StatefulWidget {
  const RincianLayananPage({super.key});

  @override
  State<RincianLayananPage> createState() =>
      _RincianLayananPageState();
}

class _RincianLayananPageState
    extends State<RincianLayananPage> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();

  bool setujuDataPribadi = false;
  String? sesiTerpilih;
  String bidangLayanan = 'Administrasi Kependudukan';
  bool sedangMengirim = false;

  bool get emailValid =>
      emailController.text.contains('@');

  bool get formLengkap =>
      namaController.text.trim().isNotEmpty &&
      emailController.text.trim().isNotEmpty &&
      emailValid &&
      setujuDataPribadi &&
      sesiTerpilih != null;

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> kirimPengajuan() async {
    setState(() {
      sedangMengirim = true;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    final pengajuan = Pengajuan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nama: namaController.text.trim(),
      email: emailController.text.trim(),
      bidangLayanan: bidangLayanan,
      sesi: sesiTerpilih!,
    );

    context
        .read<PengajuanModel>()
        .tambahPengajuan(pengajuan);

    setState(() {
      sedangMengirim = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Pengajuan berhasil dikirim',
        ),
      ),
    );

    namaController.clear();
    emailController.clear();

    setState(() {
      setujuDataPribadi = false;
      sesiTerpilih = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Formulir Pengajuan Layanan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              initialValue: bidangLayanan,
              decoration: const InputDecoration(
                labelText: 'Bidang Layanan',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Administrasi Kependudukan',
                  child: Text(
                    'Administrasi Kependudukan',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Perizinan',
                  child: Text('Perizinan'),
                ),
                DropdownMenuItem(
                  value: 'Pengaduan Masyarakat',
                  child: Text(
                    'Pengaduan Masyarakat',
                  ),
                ),
              ],
              onChanged: (nilai) {
                if (nilai != null) {
                  setState(() {
                    bidangLayanan = nilai;
                  });
                }
              },
            ),

            const SizedBox(height: 16),

            TextField(
              controller: namaController,
              onChanged: (_) {
                setState(() {});
              },
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(),
                errorText:
                    emailController.text.isNotEmpty &&
                            !emailValid
                        ? 'Email harus mengandung karakter @'
                        : null,
              ),
            ),

            const SizedBox(height: 8),

            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: setujuDataPribadi,
              title: const Text(
                'Saya menyetujui penggunaan data pribadi',
              ),
              onChanged: (nilai) {
                setState(() {
                  setujuDataPribadi =
                      nilai ?? false;
                });
              },
            ),

            const SizedBox(height: 8),

            const Text(
              'Pilih Sesi Kunjungan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            RadioListTile<String>(
              title: const Text('Pagi'),
              value: 'Pagi',
              groupValue: sesiTerpilih,
              onChanged: (nilai) {
                setState(() {
                  sesiTerpilih = nilai;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Siang'),
              value: 'Siang',
              groupValue: sesiTerpilih,
              onChanged: (nilai) {
                setState(() {
                  sesiTerpilih = nilai;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Sore'),
              value: 'Sore',
              groupValue: sesiTerpilih,
              onChanged: (nilai) {
                setState(() {
                  sesiTerpilih = nilai;
                });
              },
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    formLengkap && !sedangMengirim
                        ? kirimPengajuan
                        : null,
                child: sedangMengirim
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Kirim Pengajuan',
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}