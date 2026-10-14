import 'package:flutter/material.dart';
import '../pages/warga_page.dart';
import '../pages/rincian_layanan_page.dart';
import '../pages/chat_page.dart';
import '../pages/lokasi_kantor_page.dart';
import '../pages/statistik_layanan_page.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() =>
      _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeksTerpilih = 0;

  final List<Widget> _halaman = const [
    WargaPage(),
    RincianLayananPage(),
    ChatPage(),
    LokasiKantorPage(),
    StatistikLayananPage(),
  ];

  final List<String> _judul = const [
    'Warga',
    'Rincian Layanan',
    'Tanya Petugas',
    'Lokasi Kantor',
    'Statistik Layanan',
  ];

  void _pilihTujuan(int indeks) {
    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double lebar = MediaQuery.of(context).size.width;
    final bool layarLebar = lebar >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(_judul[_indeksTerpilih]),
      ),
      body: layarLebar
          ? _tataLetakLebar()
          : _halaman[_indeksTerpilih],
      bottomNavigationBar:
          layarLebar ? null : _buatBilahBawah(),
    );
  }

  Widget _buatBilahBawah() {
    return NavigationBar(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: _pilihTujuan,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.people_outline),
          selectedIcon: Icon(Icons.people),
          label: 'Warga',
        ),
        NavigationDestination(
          icon: Icon(Icons.description_outlined),
          selectedIcon: Icon(Icons.description),
          label: 'Layanan',
        ),
        NavigationDestination(
          icon: Icon(Icons.chat_outlined),
          selectedIcon: Icon(Icons.chat),
          label: 'Chat',
        ),
        NavigationDestination(
          icon: Icon(Icons.location_on_outlined),
          selectedIcon: Icon(Icons.location_on),
          label: 'Lokasi',
        ),
        NavigationDestination(
          icon: Icon(Icons.bar_chart_outlined),
          selectedIcon: Icon(Icons.bar_chart),
          label: 'Statistik',
        ),
      ],
    );
  }

  Widget _tataLetakLebar() {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _indeksTerpilih,
          onDestinationSelected: _pilihTujuan,
          extended: true,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.people_outline),
              selectedIcon: Icon(Icons.people),
              label: Text('Warga'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.description_outlined),
              selectedIcon: Icon(Icons.description),
              label: Text('Layanan'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.chat_outlined),
              selectedIcon: Icon(Icons.chat),
              label: Text('Chat'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.location_on_outlined),
              selectedIcon: Icon(Icons.location_on),
              label: Text('Lokasi'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.bar_chart_outlined),
              selectedIcon: Icon(Icons.bar_chart),
              label: Text('Statistik'),
            ),
          ],
        ),
        const VerticalDivider(
          thickness: 1,
          width: 1,
        ),
        Expanded(
          child: _halaman[_indeksTerpilih],
        ),
      ],
    );
  }
}