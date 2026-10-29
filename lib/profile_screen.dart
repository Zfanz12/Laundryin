import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bagianHeader(),
              const SizedBox(height: 24),
              bagianInfoPengguna(),
              const SizedBox(height: 32),
              bagianMenuProfil(),
              const SizedBox(height: 32),
              bagianTombolKeluar(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget bagianInfoPengguna() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F1FD),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0040A1).withValues(alpha: 0.15),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Color(0xFF0040A1),
              size: 54,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Zulfan Falah',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF191C1D),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '+62 812 1471 4735',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF656977),
            ),
          ),
        ],
      ),
    );
  }

  Widget bagianMenuProfil() {
    return Column(
      children: [
        itemMenuProfil(
          judul: 'Alamat Tersimpan',
          subjudul: 'Kosan Harapan Indah, Sukapura, Kab. Bandung',
          ikon: Icons.location_on_rounded,
          warnaIkon: const Color(0xFF0040A1),
          warnaLatarIkon: const Color(0xFFE8F1FD),
        ),
        const SizedBox(height: 14),
        itemMenuProfil(
          judul: 'Edit Profil',
          ikon: Icons.edit_rounded,
          warnaIkon: const Color(0xFFE53935),
          warnaLatarIkon: const Color(0xFFFFEBEE),
        ),
        const SizedBox(height: 14),
        itemMenuProfil(
          judul: 'Keamanan Akun',
          ikon: Icons.lock_outline_rounded,
          warnaIkon: const Color(0xFFFF9800),
          warnaLatarIkon: const Color(0xFFFFF3E0),
        ),
        const SizedBox(height: 14),
        itemMenuProfil(
          judul: 'Bahasa',
          subjudul: 'Indonesia',
          ikon: Icons.language_rounded,
          warnaIkon: const Color(0xFF2E7D32),
          warnaLatarIkon: const Color(0xFFE8F5E9),
        ),
        const SizedBox(height: 14),
        itemMenuProfil(
          judul: 'Bantuan & Laporan',
          ikon: Icons.help_outline_rounded,
          warnaIkon: const Color(0xFF546E7A),
          warnaLatarIkon: const Color(0xFFECEFF1),
        ),
      ],
    );
  }

  Widget itemMenuProfil({
    required String judul,
    String? subjudul,
    required IconData ikon,
    required Color warnaIkon,
    required Color warnaLatarIkon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: warnaLatarIkon,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              ikon,
              color: warnaIkon,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
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
                  const SizedBox(height: 2),
                  Text(
                    subjudul,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFA3A3A3),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFFA3A3A3),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget bagianTombolKeluar() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFD32F2F),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFD32F2F).withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.logout_rounded,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Logout',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'VERSION 12.02.06 (BUILD 420)',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFA3A3A3),
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}
