import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Halaman profil pengguna
class HalamanProfil extends StatefulWidget {
  const HalamanProfil({super.key});

  @override
  State<HalamanProfil> createState() => _HalamanProfilState();
}

class _HalamanProfilState extends State<HalamanProfil> {
  // Variabel untuk animasi tahan (hold) tombol logout
  Timer? timerTahanLogout;
  double progresTahanLogout = 0.0;
  bool sedangMenahanLogout = false;

  // Indeks menu yang sedang ditekan untuk animasi sentuh
  int? indeksMenuDitekan;

  // Fungsi saat tombol logout mulai ditekan dan ditahan
  void mulaiTahanLogout() {
    setState(() {
      sedangMenahanLogout = true;
      progresTahanLogout = 0.0;
    });

    // Setiap 20 milidetik, tambahkan progres sedikit demi sedikit (selesai dalam 1.1 detik)
    timerTahanLogout = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      setState(() {
        progresTahanLogout += 0.02;
        if (progresTahanLogout >= 1.0) {
          progresTahanLogout = 1.0;
          timer.cancel();
          sedangMenahanLogout = false;
          // Tampilkan dialog konfirmasi logout langsung saat hold selesai
          tampilkanDialogKonfirmasiLogout();
        }
      });
    });
  }

  // Fungsi saat tombol logout dilepas sebelum selesai ditahan
  void batalTahanLogout() {
    if (timerTahanLogout != null) {
      timerTahanLogout!.cancel();
    }
    setState(() {
      sedangMenahanLogout = false;
      progresTahanLogout = 0.0;
    });
  }

  @override
  void dispose() {
    timerTahanLogout?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Halaman
              bagianHeader(),
              const SizedBox(height: 24),

              // 2. Foto Profil, Nama, dan Nomor HP
              bagianProfilUtama(),
              const SizedBox(height: 32),

              // 3. Menu Pengaturan Profil
              bagianMenuProfil(),
              const SizedBox(height: 32),

              // 4. Tombol Logout dengan Animasi Tahan (Hold)
              bagianTombolLogout(),
              const SizedBox(height: 18),

              // 5. Teks Versi Aplikasi
              bagianVersiAplikasi(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // 1. Header Teks Profil
  Widget bagianHeader() {
    return Text(
      'Profil',
      style: GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF0040A1),
        letterSpacing: -0.5,
      ),
    );
  }

  // 2. Bagian Foto Profil Utama, Nama, dan Nomor Handphone
  Widget bagianProfilUtama() {
    return Center(
      child: Column(
        children: [
          // Lingkaran foto profil dengan border gradient biru dan bayangan glow
          Container(
            width: 120,
            height: 120,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0040A1),
                  Color(0xFF0056D2),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0056D2).withValues(alpha: 0.35),
                  blurRadius: 28,
                  offset: const Offset(0, 12),
                  spreadRadius: -4,
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/avatar-5a7930.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFE8F1FD),
                      child: const Icon(
                        Icons.person_rounded,
                        color: Color(0xFF0040A1),
                        size: 60,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Nama Pengguna
          Text(
            'Zulfan Falah',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF191C1D),
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 4),
          // Nomor Telepon Pengguna
          Text(
            '+6281214714735',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF424654),
            ),
          ),
        ],
      ),
    );
  }

  // 3. Bagian Daftar Menu Profil
  Widget bagianMenuProfil() {
    return Column(
      children: [
        // Menu 1: Alamat Tersimpan
        itemMenu(
          indeks: 0,
          judul: 'Alamat Tersimpan',
          subjudul:
              'Kosan Harapan Indah, Sukapura,  Kab. Bandung, Jawa Barat 11530',
          ikon: Icons.location_on_rounded,
          warnaIkon: const Color(0xFF0040A1),
          warnaLatarIkon: const Color(0xFFE8F1FD),
        ),
        const SizedBox(height: 14),

        // Menu 2: Edit Profil
        itemMenu(
          indeks: 1,
          judul: 'Edit Profil',
          ikon: Icons.edit_rounded,
          warnaIkon: const Color(0xFF9747FF),
          warnaLatarIkon: const Color(0xFFF3E8FF),
        ),
        const SizedBox(height: 14),

        // Menu 3: Keamanan Akun
        itemMenu(
          indeks: 2,
          judul: 'Keamanan Akun',
          ikon: Icons.lock_outline_rounded,
          warnaIkon: const Color(0xFF8B5000),
          warnaLatarIkon: const Color(0xFFFFF3E0),
        ),
        const SizedBox(height: 14),

        // Menu 4: Bahasa
        itemMenu(
          indeks: 3,
          judul: 'Bahasa',
          subjudul: 'Indonesia',
          ikon: Icons.language_rounded,
          warnaIkon: const Color(0xFF005312),
          warnaLatarIkon: const Color(0xFFE8F5E9),
        ),
        const SizedBox(height: 14),

        // Menu 5: Bantuan & Laporan
        itemMenu(
          indeks: 4,
          judul: 'Bantuan & Laporan',
          ikon: Icons.headset_mic_rounded,
          warnaIkon: const Color(0xFF424654),
          warnaLatarIkon: const Color(0xFFECEFF1),
        ),
      ],
    );
  }

  // Desain kartu untuk setiap baris menu dengan animasi sentuh (tanpa snackbar)
  Widget itemMenu({
    required int indeks,
    required String judul,
    String? subjudul,
    required IconData ikon,
    required Color warnaIkon,
    required Color warnaLatarIkon,
  }) {
    final bool sedangDitekan = (indeksMenuDitekan == indeks);

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          indeksMenuDitekan = indeks;
        });
      },
      onTapUp: (_) {
        setState(() {
          indeksMenuDitekan = null;
        });
      },
      onTapCancel: () {
        setState(() {
          indeksMenuDitekan = null;
        });
      },
      child: AnimatedScale(
        scale: sedangDitekan ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInOut,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Kotak Ikon Menu
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: warnaLatarIkon,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  ikon,
                  color: warnaIkon,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              // Teks Judul dan Subjudul
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      judul,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF191C1D),
                      ),
                    ),
                    if (subjudul != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        subjudul,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF646E77),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Panah ke kanan
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFA3A3A3),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 4. Tombol Logout dengan Animasi Tahan (Hold) Tanpa SnackBar
  Widget bagianTombolLogout() {
    return GestureDetector(
      // Mulai tahan
      onTapDown: (_) => mulaiTahanLogout(),
      onTapUp: (_) {
        if (progresTahanLogout < 1.0) {
          batalTahanLogout();
        }
      },
      onTapCancel: () => batalTahanLogout(),
      child: AnimatedScale(
        scale: sedangMenahanLogout ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFA10000),
                Color(0xFFD20000),
              ],
            ),
            borderRadius: BorderRadius.circular(9999),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFA10000).withValues(alpha: 0.35),
                blurRadius: 18,
                offset: const Offset(0, 6),
                spreadRadius: -2,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Efek bar pengisi animasi saat tombol sedang ditahan
              if (sedangMenahanLogout)
                ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: progresTahanLogout,
                      heightFactor: 1.0,
                      child: Container(
                        color: Colors.white.withValues(alpha: 0.25),
                      ),
                    ),
                  ),
                ),
              // Ikon dan Teks Logout
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.logout_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      sedangMenahanLogout ? 'Tahan...' : 'Logout',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 5. Teks Versi Aplikasi di Bagian Paling Bawah
  Widget bagianVersiAplikasi() {
    return Center(
      child: Text(
        'VERSION 12.02.06 (BUILD 420)',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFA3A3A3),
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  // Modal dialog konfirmasi keluar saat tombol hold selesai ditahan
  void tampilkanDialogKonfirmasiLogout() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFEBEE),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFD20000),
                  size: 28,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Konfirmasi Logout',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF191C1D),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Apakah Anda yakin ingin keluar dari akun LaundryIn ini?',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: const Color(0xFFA3A3A3),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        side: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      child: Text(
                        'Batal',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF191C1D),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD20000),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                      child: Text(
                        'Ya, Keluar',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
