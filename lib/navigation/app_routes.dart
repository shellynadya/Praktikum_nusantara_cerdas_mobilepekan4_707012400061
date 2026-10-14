import 'package:flutter/material.dart';
import '../pages/rincian_layanan_page.dart';
import '../pages/detail_pengajuan_page.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String rincianLayanan = '/rincian-layanan';
  static const String detailPengajuan = '/detail-pengajuan';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      rincianLayanan: (context) => const RincianLayananPage(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    if (settings.name == detailPengajuan) {
      final id = settings.arguments as String;

      return MaterialPageRoute(
        builder: (context) => DetailPengajuanPage(
          pengajuanId: id,
        ),
      );
    }

    return null;
  }

  static Route<dynamic> routeTidakDikenal(
    RouteSettings settings,
  ) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Route Tidak Ditemukan'),
        ),
        body: Center(
          child: Text(
            'Route ${settings.name} belum terdaftar.',
          ),
        ),
      ),
    );
  }
}