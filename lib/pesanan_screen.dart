import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pembayaran_screen.dart';

// ====================================================================
// HALAMAN PESANAN (Tab "PESANAN" di navigasi bawah)
// Isi: Ringkasan (Total Pesanan & Hemat Waktu), Pesanan Aktif, Riwayat
// Full Front-End Only (data dummy), Kode Sederhana & Ramah Pemula
// ====================================================================
class HalamanPesanan extends StatelessWidget {
  const HalamanPesanan({super.key});

  static const Color warnaBiru = Color(0xFF0040A1);
  static const Color warnaTeksGelap = Color(0xFF191C1D);
  static const Color warnaTeksAbu = Color(0xFF737785);

  // ------------------------------------------------------------------
  // DATA DUMMY: Pesanan Aktif
  // 'hijau' true  -> titik hijau (DIANTAR / SELESAI)
  // 'hijau' false -> titik oranye (proses lainnya)
  // 'progres' null -> progress bar & estimasi disembunyikan (riwayat)
  // 'aksi' -> tombol di bagian bawah kartu
  // ------------------------------------------------------------------
  static const List<Map<String, dynamic>> pesananAktif = [
    {
      'id': '#ZF-1200',
      'layanan': 'Instant • Cuci & Gosok',
      'tanggal': '24 Oktober 2026',
      'status': 'DIANTAR',
      'hijau': true,
      'item': '1 Baju • 2 Celana • 2 Lainnya',
      'berat': '1.6Kg',
      'harga': 'Rp95.000',
      'progres': 0.95,
      'estimasiLabel': 'Estimasi Sampai',
      'estimasi': '7 Menit',
      'aksi': ['Detail', 'Track'],
    },
    {
      'id': '#ZF-1234',
      'layanan': 'Instant • Cuci & Gosok',
      'tanggal': '24 Oktober 2026',
      'status': 'DICUCI',
      'hijau': false,
      'item': '6 Baju • 3 Celana • 1 Lainnya',
      'berat': '5.2Kg',
      'harga': 'Rp107.000',
      'progres': 0.6,
      'estimasiLabel': 'Estimasi Selesai',
      'estimasi': '2 jam',
      'aksi': ['Detail'],
    },
    {
      'id': '#ZF-2709',
      'layanan': 'Regular • Cuci Saja',
      'tanggal': '24 Oktober 2026',
      'status': 'ANTREAN',
      'hijau': false,
      'item': '2 Baju • 1 Seprei',
      'berat': '4.6Kg',
      'harga': null,
      'progres': 0.5,
      'estimasiLabel': 'Estimasi Selesai',
      'estimasi': '4 jam',
      'aksi': ['Detail'],
    },
    {
      'id': '#ZF-1227',
      'layanan': 'Regular • Gosok Saja',
      'tanggal': '24 Oktober 2026',
      'status': 'BAYAR',
      'hijau': false,
      'item': '7 Celana • 3 Lainnya',
      'berat': '10.2Kg',
      'harga': 'Rp215.000',
      'progres': 0.25,
      'estimasiLabel': 'Estimasi Selesai',
      'estimasi': '~',
      'aksi': ['Bayar'],
    },
    {
      'id': '#ZF-2709',
      'layanan': 'Regular • Gosok Saja',
      'tanggal': '24 Oktober 2026',
      'status': 'DIHITUNG',
      'hijau': false,
      'item': 'sedang dihitung...',
      'berat': 'sedang dihitung...',
      'harga': null,
      'progres': 0.15,
      'estimasiLabel': 'Estimasi Selesai',
      'estimasi': '~',
      'aksi': ['Detail'],
    },
    {
      'id': '#ZF-1202',
      'layanan': 'Instant • Gosok Saja',
      'tanggal': '24 Oktober 2026',
      'status': 'DIJEMPUT',
      'hijau': false,
      'item': 'Baju • Sprei',
      'berat': '~',
      'harga': null,
      'progres': 0.03,
      'estimasiLabel': 'Estimasi Selesai',
      'estimasi': '24+ jam',
      'aksi': ['Detail', 'Track'],
    },
  ];

  // ------------------------------------------------------------------
  // DATA DUMMY: Riwayat Pesanan (semua SELESAI, tanpa progress bar)
  // ------------------------------------------------------------------
  static const List<Map<String, dynamic>> riwayatPesanan = [
    {
      'id': '#ZF-0101',
      'layanan': 'Regular • Cuci & Gosok',
      'tanggal': '24 Oktober 2026',
      'status': 'SELESAI',
      'hijau': true,
      'item': '1 Baju',
      'berat': '1.1Kg',
      'harga': 'Rp145.000',
      'progres': null,
      'aksi': ['Detail'],
    },
    {
      'id': '#ZF-6991',
      'layanan': 'Regular • Cuci & Gosok',
      'tanggal': '24 Oktober 2026',
      'status': 'SELESAI',
      'hijau': true,
      'item': '2 Baju',
      'berat': '5.9Kg',
      'harga': 'Rp65.000',
      'progres': null,
      'aksi': ['Detail'],
    },
    {
      'id': '#ZF-5173',
      'layanan': 'Instant • Gosok Saja',
      'tanggal': '24 Oktober 2026',
      'status': 'SELESAI',
      'hijau': true,
      'item': '3 Sepatu',
      'berat': '4.7Kg',
      'harga': 'Rp52.000',
      'progres': null,
      'aksi': ['Detail'],
    },
    {
      'id': '#ZF-1241',
      'layanan': 'Instant • Cuci Saja',
      'tanggal': '24 Oktober 2026',
      'status': 'SELESAI',
      'hijau': true,
      'item': '25 Baju',
      'berat': '80.1Kg',
      'harga': 'Rp716.000',
      'progres': null,
      'aksi': ['Detail'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Judul Halaman
              Text(
                'Pesanan',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: warnaBiru,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 18),

              // 2. Ringkasan (Total Pesanan & Hemat Waktu)
              bagianRingkasan(),
              const SizedBox(height: 28),

              // 3. Pesanan Aktif
              judulBagian('Pesanan Aktif'),
              const SizedBox(height: 14),
              ...pesananAktif.map(
                (pesanan) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: kartuPesanan(context, pesanan),
                ),
              ),
              const SizedBox(height: 12),

              // 4. Riwayat Pesanan
              judulBagian('Riwayat pesanan'),
              const SizedBox(height: 14),
              ...riwayatPesanan.map(
                (pesanan) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: kartuPesanan(context, pesanan),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // WIDGET: JUDUL BAGIAN + IKON FILTER
  // ==========================================================
  Widget judulBagian(String judul) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          judul,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: warnaTeksGelap,
            letterSpacing: -0.3,
          ),
        ),
        const Icon(
          Icons.filter_list_rounded,
          color: warnaBiru,
          size: 22,
        ),
      ],
    );
  }

  // ==========================================================
  // WIDGET: RINGKASAN (2 KARTU: TOTAL PESANAN & HEMAT WAKTU)
  // ==========================================================
  Widget bagianRingkasan() {
    return Row(
      children: [
        // Kartu Putih: Total Pesanan
        Expanded(
          child: Container(
            height: 96,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -4,
                  top: -4,
                  child: Icon(
                    Icons.receipt_long_rounded,
                    size: 52,
                    color: warnaTeksAbu.withValues(alpha: 0.15),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TOTAL PESANAN',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: warnaTeksAbu,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '24',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: warnaBiru,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 14),

        // Kartu Biru: Hemat Waktu
        Expanded(
          child: Container(
            height: 96,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0040A1), Color(0xFF0056D2)],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: warnaBiru.withValues(alpha: 0.3),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -6,
                  bottom: -10,
                  child: Icon(
                    Icons.schedule_rounded,
                    size: 58,
                    color: Colors.white.withValues(alpha: 0.12),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HEMAT WAKTU',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: 0.8),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '36J',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // WIDGET: KARTU PESANAN (dipakai untuk Aktif & Riwayat)
  // ==========================================================
  Widget kartuPesanan(BuildContext context, Map<String, dynamic> pesanan) {
    final bool hijau = pesanan['hijau'] as bool;
    final Color warnaTitik =
        hijau ? const Color(0xFF03AF23) : const Color(0xFFFF9800);
    final Color warnaLatarBadge =
        hijau ? const Color(0xFFF0FFF3) : const Color(0xFFFFF5E6);
    final Color warnaGlow =
        hijau ? const Color(0xFF5CDF63) : const Color(0xFFFF9800);

    final double? progres = pesanan['progres'] as double?;
    final String? harga = pesanan['harga'] as String?;
    final List<String> daftarAksi = (pesanan['aksi'] as List).cast<String>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            // Glow warna status di pojok kanan atas
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      warnaGlow.withValues(alpha: 0.22),
                      warnaGlow.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),

            // Isi Kartu
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Baris atas: Ikon, Info Pesanan, Badge Status
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF4FB),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.local_laundry_service_rounded,
                          color: warnaBiru,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pesanan['layanan'] as String,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: warnaTeksAbu,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              pesanan['id'] as String,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: warnaTeksGelap,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              pesanan['tanggal'] as String,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: warnaTeksAbu,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Badge Status (titik + teks)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: warnaLatarBadge,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: warnaTitik,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              pesanan['status'] as String,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: warnaTeksGelap,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Baris tengah: Detail Item (kiri) & Total Harga (kanan)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Detail Item',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: warnaTeksAbu,
                              ),
                            ),
                            const SizedBox(height: 8),
                            barisDetail(
                              Icons.checkroom_rounded,
                              pesanan['item'] as String,
                            ),
                            const SizedBox(height: 6),
                            barisDetail(
                              Icons.scale_outlined,
                              pesanan['berat'] as String,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Total Harga',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: warnaTeksAbu,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            harga ?? '~',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: warnaBiru,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Progress bar & estimasi (hanya untuk pesanan aktif)
                  if (progres != null) ...[
                    const SizedBox(height: 16),
                    progressBar(progres),
                    const SizedBox(height: 14),
                    barisEstimasi(
                      pesanan['estimasiLabel'] as String,
                      pesanan['estimasi'] as String,
                    ),
                  ],
                  const SizedBox(height: 8),

                  // Tombol aksi (Detail / Track / Bayar)
                  Row(
                    children: daftarAksi.map((teks) {
                      return Expanded(
                        child: TextButton(
                          onPressed: () {
                            // tombol Bayar -> halaman pembayaran
                            if (teks == 'Bayar') {
                              // "Rp215.000" -> 215000
                              final total = int.parse(
                                (harga ?? '0').replaceAll(RegExp(r'[^0-9]'), ''),
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MetodePembayaranScreen(
                                    orderId: pesanan['id'] as String,
                                    total: total,
                                  ),
                                ),
                              );
                            }
                            // Detail & Track belum ada (menunggu halaman terkait)
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: warnaBiru,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            teks,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: warnaBiru,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Satu baris detail: ikon + teks (abu-abu kalau masih "sedang dihitung")
  Widget barisDetail(IconData ikon, String teks) {
    final bool redup = teks.startsWith('sedang');
    return Row(
      children: [
        Icon(ikon, size: 16, color: warnaTeksAbu),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            teks,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: redup ? warnaTeksAbu : warnaTeksGelap,
            ),
          ),
        ),
      ],
    );
  }

  // Progress bar biru (0.0 - 1.0)
  Widget progressBar(double nilai) {
    return Container(
      height: 6,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFE7E8E9),
        borderRadius: BorderRadius.circular(9999),
      ),
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: nilai.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: warnaBiru,
            borderRadius: BorderRadius.circular(9999),
          ),
        ),
      ),
    );
  }

  // Baris estimasi: ikon jam + "Estimasi Sampai: 7 Menit"
  Widget barisEstimasi(String label, String nilai) {
    return Row(
      children: [
        const Icon(
          Icons.schedule_rounded,
          size: 15,
          color: Color(0xFF8B5000),
        ),
        const SizedBox(width: 6),
        Text.rich(
          TextSpan(
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: warnaTeksGelap,
            ),
            children: [
              TextSpan(text: '$label: '),
              TextSpan(
                text: nilai,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: warnaTeksGelap,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
