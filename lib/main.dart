import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'pesanan_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(const AplikasiLaundry());
}

class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    );
  }
}

class AplikasiLaundry extends StatelessWidget {
  const AplikasiLaundry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LaundryIn',
      scrollBehavior: const AppScrollBehavior(),
      home: const NavigasiUtama(),
    );
  }
}

class NavigasiUtama extends StatefulWidget {
  const NavigasiUtama({super.key});

  @override
  State<NavigasiUtama> createState() => _NavigasiUtamaState();
}

class _NavigasiUtamaState extends State<NavigasiUtama> {
  int indexSaatIni = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> daftarHalaman = [
      // Halaman Home
      HalamanUtama(
        onKeProfil: () {
          setState(() {
            indexSaatIni = 3;
          });
        },
      ),
      // Halaman Pesanan
      const HalamanPesanan(),
      // Halaman Notifikasi (Placeholder Front End)
      const Scaffold(
        backgroundColor: Color(0xFFF8F9FA),
        body: Center(
          child: Text(
            'Halaman Notifikasi\n(Segera Hadir)',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ),
      // Halaman Profil
      const HalamanProfil(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: indexSaatIni,
        children: daftarHalaman,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(32),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 32,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(32),
          ),
          child: SizedBox(
            height: 64,
            child: BottomNavigationBar(
              currentIndex: indexSaatIni,
              onTap: (indexBaru) {
                setState(() {
                  indexSaatIni = indexBaru;
                });
              },
              selectedItemColor: const Color(0xFF0040A1),
              unselectedItemColor: const Color(0xFFA3A3A3),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              elevation: 0,
              iconSize: 24,
              selectedLabelStyle: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
              unselectedLabelStyle: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
              ),
              items: const [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Icon(Icons.home_rounded),
                  ),
                  label: 'BERANDA',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Icon(Icons.receipt_long_rounded),
                  ),
                  label: 'PESANAN',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Icon(Icons.notifications_none_rounded),
                  ),
                  label: 'NOTIFIKASI',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Icon(Icons.person_rounded),
                  ),
                  label: 'PROFIL',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
