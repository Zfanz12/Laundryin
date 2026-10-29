import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(const AplikasiLaundry());
}

class AplikasiLaundry extends StatelessWidget {
  const AplikasiLaundry({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LaundryIn',
      home: NavigasiUtama(),
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
      HalamanUtama(
        onKeProfil: () {
          setState(() {
            indexSaatIni = 3;
          });
        },
      ),
      const Scaffold(
        backgroundColor: Color(0xFFF8F9FA),
        body: Center(
          child: Text(
            'Pesanan\n(Nanti bingung)',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ),
      const Scaffold(
        backgroundColor: Color(0xFFF8F9FA),
        body: Center(
          child: Text(
            'Notifikasi\n(yh nnti)',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ),
      const HalamanProfil(),
    ];

    return Scaffold(
      body: daftarHalaman[indexSaatIni],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
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
          selectedLabelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
          unselectedLabelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_rounded),
              label: 'PESANAN',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_rounded),
              label: 'NOTIFIKASI',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'PROFIL',
            ),
          ],
        ),
      ),
    );
  }
}
