import 'package:flutter/foundation.dart';

class Pengajuan {
  final String id;
  final String nama;
  final String email;
  final String bidangLayanan;
  final String sesi;
  bool selesaiDitindaklanjuti;

  Pengajuan({
    required this.id,
    required this.nama,
    required this.email,
    required this.bidangLayanan,
    required this.sesi,
    this.selesaiDitindaklanjuti = false,
  });
}

class PengajuanModel extends ChangeNotifier {
  final List<Pengajuan> _daftarPengajuan = [];

  List<Pengajuan> get daftarPengajuan =>
      List.unmodifiable(_daftarPengajuan);

  void tambahPengajuan(Pengajuan pengajuan) {
    _daftarPengajuan.add(pengajuan);
    notifyListeners();
  }

  void tandaiSelesai(String id) {
    final index = _daftarPengajuan.indexWhere(
      (pengajuan) => pengajuan.id == id,
    );

    if (index != -1) {
      _daftarPengajuan[index].selesaiDitindaklanjuti = true;
      notifyListeners();
    }
  }

  int jumlahBidang(String bidangLayanan) {
    return _daftarPengajuan
        .where(
          (pengajuan) =>
              pengajuan.bidangLayanan == bidangLayanan,
        )
        .length;
  }

  Pengajuan? cariPengajuan(String id) {
    try {
      return _daftarPengajuan.firstWhere(
        (pengajuan) => pengajuan.id == id,
      );
    } catch (_) {
      return null;
    }
  }
}