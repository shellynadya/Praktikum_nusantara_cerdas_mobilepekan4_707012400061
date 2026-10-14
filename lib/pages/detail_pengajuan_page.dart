import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pengajuan_model.dart';

class DetailPengajuanPage extends StatelessWidget {
  final String pengajuanId;

  const DetailPengajuanPage({
    super.key,
    required this.pengajuanId,
  });

  @override
  Widget build(BuildContext context) {
    final pengajuan = context
        .watch<PengajuanModel>()
        .cariPengajuan(pengajuanId);

    if (pengajuan == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Rincian Pengajuan'),
        ),
        body: const Center(
          child: Text(
            'Data pengajuan tidak ditemukan.',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian Pengajuan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  pengajuan.bidangLayanan,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Nama: ${pengajuan.nama}',
                ),
                const SizedBox(height: 8),
                Text(
                  'Email: ${pengajuan.email}',
                ),
                const SizedBox(height: 8),
                Text(
                  'Sesi Kunjungan: ${pengajuan.sesi}',
                ),
                const SizedBox(height: 8),
                Text(
                  'Status: ${pengajuan.selesaiDitindaklanjuti ? 'Selesai ditindaklanjuti' : 'Menunggu tindak lanjut'}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}