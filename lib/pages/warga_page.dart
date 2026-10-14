import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengajuanModel>();
    final daftarPengajuan = model.daftarPengajuan;

    return Scaffold(
      body: daftarPengajuan.isEmpty
          ? const Center(
              child: Text(
                'Belum ada pengajuan layanan.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: daftarPengajuan.length,
              itemBuilder: (context, index) {
                final pengajuan = daftarPengajuan[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.detailPengajuan,
                      arguments: pengajuan.id,
                    );
                  },
                  onLongPress: () {
                    context
                        .read<PengajuanModel>()
                        .tandaiSelesai(pengajuan.id);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Pengajuan selesai ditindaklanjuti',
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Icon(
                        pengajuan.selesaiDitindaklanjuti
                            ? Icons.check_circle
                            : Icons.pending_actions,
                      ),
                      title: Text(pengajuan.bidangLayanan),
                      subtitle: Text(
                        '${pengajuan.nama}\n'
                        'Sesi ${pengajuan.sesi}\n'
                        '${pengajuan.selesaiDitindaklanjuti ? 'Selesai ditindaklanjuti' : 'Menunggu tindak lanjut'}',
                      ),
                      isThreeLine: true,
                      trailing: const Icon(
                        Icons.chevron_right,
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.rincianLayanan,
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Pengajuan Baru'),
      ),
    );
  }
}