import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../model/pengajuan_model.dart';

class StatistikLayananPage extends StatelessWidget {
  const StatistikLayananPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengajuanModel>();

    final jumlahAdministrasi =
        model.jumlahBidang('Administrasi Kependudukan');

    final jumlahPerizinan =
        model.jumlahBidang('Perizinan');

    final jumlahPengaduan =
        model.jumlahBidang('Pengaduan Masyarakat');

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistik Layanan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Jumlah pengajuan pada setiap bidang layanan',
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment:
                      BarChartAlignment.spaceAround,
                  maxY: _nilaiMaksimum(
                    jumlahAdministrasi,
                    jumlahPerizinan,
                    jumlahPengaduan,
                  ),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: jumlahAdministrasi
                              .toDouble(),
                          width: 28,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY:
                              jumlahPerizinan.toDouble(),
                          width: 28,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY:
                              jumlahPengaduan.toDouble(),
                          width: 28,
                        ),
                      ],
                    ),
                  ],
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget:
                            (value, meta) {
                          String judul;

                          switch (value.toInt()) {
                            case 0:
                              judul = 'Administrasi';
                              break;
                            case 1:
                              judul = 'Perizinan';
                              break;
                            case 2:
                              judul = 'Pengaduan';
                              break;
                            default:
                              judul = '';
                          }

                          return SideTitleWidget(
                            meta: meta,
                            child: Text(
                              judul,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  gridData: const FlGridData(
                    show: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static double _nilaiMaksimum(
    int administrasi,
    int perizinan,
    int pengaduan,
  ) {
    final nilaiTerbesar = [
      administrasi,
      perizinan,
      pengaduan,
    ].reduce((a, b) => a > b ? a : b);

    if (nilaiTerbesar < 5) {
      return 5;
    }

    return nilaiTerbesar.toDouble() + 1;
  }
}