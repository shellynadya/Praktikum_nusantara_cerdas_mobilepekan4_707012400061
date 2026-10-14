import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/pengajuan_model.dart';
import 'navigation/app_routes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PengajuanModel(),
      child: MaterialApp(
        title: 'Nusantara Cerdas Mobile',
        initialRoute: AppRoutes.beranda,
        routes: AppRoutes.daftarRoute(),
        onGenerateRoute: AppRoutes.bentukRoute,
        onUnknownRoute: AppRoutes.routeTidakDikenal,
      ),
    ),
  );
}