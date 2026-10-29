import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HalamanUtama extends StatelessWidget {
  final VoidCallback? onKeProfil;

  const HalamanUtama({super.key, this.onKeProfil});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bagianHeader(),
              const SizedBox(height: 24),
              bagianBannerPromo(),
              const SizedBox(height: 28),
              bagianPesananAktif(),
              const SizedBox(height: 28),
              bagianLayanan(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget bagianHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat pagi,',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFFA3A3A3),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Zulfan!',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0040A1),
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: onKeProfil,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F1FD),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0040A1).withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Color(0xFF0040A1),
              size: 26,
            ),
          ),
        ),
      ],
    );
  }

  Widget bagianBannerPromo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0056D2),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF004AB3).withValues(alpha: 0.45),
            blurRadius: 24,
            offset: const Offset(0, 10),
            spreadRadius: -4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pesan laundry\nantar - jemput sekarang!',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 23,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.25,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Pesan Sekarang',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0040A1),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: Color(0xFF0040A1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bagianPesananAktif() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pesanan Aktif',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF191C1D),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 14),
        kartuPesanan(
          nomorPesanan: '#ZF-1227',
          statusPesanan: 'MENUNGGU PEMBAYARAN',
          warnaStatus: const Color(0xFFFF9800),
          labelEstimasi: 'Estimasi Selesai',
          waktuEstimasi: '6 Jam',
        ),
        const SizedBox(height: 12),
        kartuPesanan(
          nomorPesanan: '#ZF-1202',
          statusPesanan: 'SEDANG DIJEMPUT',
          warnaStatus: const Color(0xFFFF9800),
          labelEstimasi: 'Estimasi Sampai',
          waktuEstimasi: '15 Menit',
        ),
        const SizedBox(height: 12),
        kartuPesanan(
          nomorPesanan: '#ZF-1234',
          statusPesanan: 'SEDANG DICUCI',
          warnaStatus: const Color(0xFF007BFF),
          labelEstimasi: 'Estimasi Selesai',
          waktuEstimasi: '2 Jam',
        ),
      ],
    );
  }

  Widget kartuPesanan({
    required String nomorPesanan,
    required String statusPesanan,
    required Color warnaStatus,
    required String labelEstimasi,
    required String waktuEstimasi,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ORDER ID',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      color: const Color(0xFFA3A3A3),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    nomorPesanan,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF191C1D),
                    ),
                  ),
                ],
              ),
              Text(
                statusPesanan,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: warnaStatus,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(
                Icons.access_time_rounded,
                size: 14,
                color: Color(0xFF8B5000),
              ),
              const SizedBox(width: 5),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: const Color(0xFF424654),
                  ),
                  children: [
                    TextSpan(
                      text: '$labelEstimasi: ',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: waktuEstimasi,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF191C1D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bagianLayanan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ada layanan apa aja sih?',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF191C1D),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'Jenis',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0040A1),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Tipe',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF8F8F8F),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        kartuLayanan(
          judul: 'Regular',
          deskripsi: 'Pencucian premium standar dalam 48 jam kerja.',
          ikon: Icons.local_laundry_service_rounded,
          warnaIkon: const Color(0xFF0040A1),
        ),
        const SizedBox(height: 12),
        kartuLayanan(
          judul: 'Express',
          deskripsi: 'Selesai dalam 24 jam. Cocok untuk kebutuhan mendesak.',
          ikon: Icons.flash_on_rounded,
          warnaIkon: const Color(0xFFFF9800),
        ),
        const SizedBox(height: 12),
        kartuLayanan(
          judul: 'Instant',
          deskripsi: 'Layanan prioritas kilat. Selesai dalam 6 jam.',
          ikon: Icons.rocket_launch_rounded,
          warnaIkon: const Color(0xFF1C6D24),
        ),
      ],
    );
  }

  Widget kartuLayanan({
    required String judul,
    required String deskripsi,
    required IconData ikon,
    required Color warnaIkon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: warnaIkon,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: warnaIkon.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(ikon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF191C1D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  deskripsi,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: const Color(0xFFA3A3A3),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
