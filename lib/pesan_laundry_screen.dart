import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'konfirmasi_pesanan.dart';

// ====================================================================
// HALAMAN PESAN LAUNDRY (Pesan Laundry Remake - Figma #293:1587)
// Full Front-End Only, Kode Sederhana & Ramah Pemula
// ====================================================================
class HalamanPesanLaundry extends StatefulWidget {
  const HalamanPesanLaundry({super.key});

  @override
  State<HalamanPesanLaundry> createState() => _HalamanPesanLaundryState();
}

class _HalamanPesanLaundryState extends State<HalamanPesanLaundry> {
  // Pilihan Jenis Layanan (0: Cuci Gosok, 1: Gosok Saja, 2: Cuci Saja)
  int jenisLayananDipilih = 0;

  // Pilihan Kecepatan Layanan (0: Reguler, 1: Express, 2: Instant)
  // Default di Figma adalah Express (indeks 1)
  int kecepatanDipilih = 1;

  // Pilihan Kategori Item (Bisa multi-select)
  // Default di Figma adalah 'Pakaian' aktif
  final Set<String> kategoriTerpilih = {'Pakaian'};

  // Controller untuk kolom input catatan tambahan
  final TextEditingController catatanController = TextEditingController();

  // Animasi skala tombol aksi di bawah saat ditekan (interaksi sentuh)
  double skalaTombolAksi = 1.0;

  // Perhitungan estimasi biaya dummy berdasarkan pilihan layanan & kecepatan
  String get estimasiBiaya {
    if (kecepatanDipilih == 0) {
      return 'Rp 45.000 - Rp 65.000';
    } else if (kecepatanDipilih == 1) {
      return 'Rp 65.000 - Rp 95.000'; // Sesuai tampilan Figma (#310:2086)
    } else {
      return 'Rp 95.000 - Rp 130.000';
    }
  }

  @override
  void dispose() {
    catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

      // Header Atas 1:1 Sesuai Figma (#293:1708)
      // Tanpa lingkaran biru aneh, tombol panah langsung menyatu dengan judul
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.95),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Color(0xFF1D4ED8),
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Pesan Laundry',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                      letterSpacing: -0.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // Badan Halaman yang Dapat Di-scroll
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Bagian Jenis Layanan (Cuci Gosok, Gosok Saja, Cuci Saja)
            bagianJenisLayanan(),
            const SizedBox(height: 32),

            // 2. Bagian Kecepatan Layanan (Reguler, Express, Instant)
            bagianKecepatanLayanan(),
            const SizedBox(height: 32),

            // 3. Bagian Kategori Item (Pakaian, Sepatu, Sprei, Lainnya)
            bagianKategoriItem(),
            const SizedBox(height: 32),

            // 4. Bagian Alamat & Jadwal Penjemputan (Bento Cards)
            bagianAlamatDanJadwal(),
            const SizedBox(height: 32),

            // 5. Bagian Catatan Tambahan (Opsional)
            bagianCatatanTambahan(),
          ],
        ),
      ),

      // Bottom Bar Aksi Biaya & Tombol Pesan Sekarang (#310:2086)
      bottomSheet: bagianBawahAksi(),
    );
  }

  // ==========================================================
  // 1. WIDGET: PILIHAN JENIS LAYANAN (#293:1590)
  // ==========================================================
  Widget bagianJenisLayanan() {
    final daftarJenis = ['Cuci Gosok', 'Gosok Saja', 'Cuci Saja'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul Bagian + Label Wajib Diisi
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'JENIS LAYANAN',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF737785),
                letterSpacing: 1.2,
              ),
            ),
            Text(
              'Wajib diisi',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0040A1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Segmented Control 3 Tombol (Persis Figma #302:1815)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: List.generate(daftarJenis.length, (indeks) {
              final isDipilih = (jenisLayananDipilih == indeks);
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      jenisLayananDipilih = indeks;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isDipilih ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isDipilih
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : [],
                    ),
                    child: Center(
                      child: Text(
                        daftarJenis[indeks],
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight:
                              isDipilih ? FontWeight.w700 : FontWeight.w600,
                          color: isDipilih
                              ? const Color(0xFF0040A1)
                              : const Color(0xFF424654),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // 2. WIDGET: PILIHAN KECEPATAN LAYANAN (#293:1601)
  // Sesuai Prototype Figma: Kartu terpilih berubah warna penuh & glow
  // ==========================================================
  Widget bagianKecepatanLayanan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'KECEPATAN LAYANAN',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF737785),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 14),

        // Kartu 1: Reguler (Biru Penuh saat aktif)
        kartuKecepatan(
          indeks: 0,
          nama: 'Reguler',
          deskripsi: '48 jam pengerjaan',
          ikon: Icons.access_time_rounded,
          warnaGradient: const [
            Color(0xFF0E63DE),
            Color(0xFF1469E3),
          ],
          warnaGlow: const Color(0xFF0F64DF),
        ),
        const SizedBox(height: 14),

        // Kartu 2: Express (Kuning Emas Penuh saat aktif - Default Figma)
        kartuKecepatan(
          indeks: 1,
          nama: 'Express',
          deskripsi: '24 jam pengerjaan',
          ikon: Icons.flash_on_rounded,
          warnaGradient: const [
            Color(0xFFF3BB01),
            Color(0xFFF6C601),
          ],
          warnaGlow: const Color(0xFFF3BB01),
        ),
        const SizedBox(height: 14),

        // Kartu 3: Instant (Hijau Penuh saat aktif)
        kartuKecepatan(
          indeks: 2,
          nama: 'Instant',
          deskripsi: '6 jam pengerjaan',
          ikon: Icons.rocket_launch_rounded,
          warnaGradient: const [
            Color(0xFF2BBC3B),
            Color(0xFF33C243),
          ],
          warnaGlow: const Color(0xFF2BBC3B),
        ),
      ],
    );
  }

  // Komponen Kartu Kecepatan Interaktif 1:1 Sesuai Prototype Figma
  Widget kartuKecepatan({
    required int indeks,
    required String nama,
    required String deskripsi,
    required IconData ikon,
    required List<Color> warnaGradient,
    required Color warnaGlow,
  }) {
    final isDipilih = (kecepatanDipilih == indeks);

    return GestureDetector(
      onTap: () {
        setState(() {
          kecepatanDipilih = indeks;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDipilih ? null : Colors.white,
          gradient: isDipilih
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: warnaGradient,
                )
              : null,
          borderRadius: BorderRadius.circular(24),
          boxShadow: isDipilih
              ? [
                  BoxShadow(
                    color: warnaGlow.withValues(alpha: 0.45),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              // Kotak Ikon (Transparan putih saat aktif, abu muda saat tidak aktif)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDipilih
                      ? Colors.white.withValues(alpha: 0.22)
                      : const Color(0xFFF3F4F5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  ikon,
                  color: isDipilih ? Colors.white : const Color(0xFF424654),
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),

              // Teks Nama dan Estimasi Waktu Pengerjaan
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color:
                            isDipilih ? Colors.white : const Color(0xFF191C1D),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      deskripsi,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: isDipilih
                            ? Colors.white.withValues(alpha: 0.85)
                            : const Color(0xFF737785),
                      ),
                    ),
                  ],
                ),
              ),

              // Indikator Radio Donut (Putih tebal saat aktif, abu-abu saat tidak aktif)
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(
                    color: isDipilih ? Colors.white : const Color(0xFFE7E8E9),
                    width: isDipilih ? 3.5 : 2.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // 3. WIDGET: PILIHAN KATEGORI ITEM (#293:1636)
  // ==========================================================
  Widget bagianKategoriItem() {
    final daftarKategori = [
      {'nama': 'Pakaian', 'ikon': Icons.checkroom_rounded},
      {'nama': 'Sepatu', 'ikon': Icons.roller_skating_rounded},
      {'nama': 'Sprei', 'ikon': Icons.bed_rounded},
      {'nama': 'Lainnya', 'ikon': Icons.more_horiz_rounded},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'KATEGORI ITEM',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF737785),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 14),

        // 4 Kartu Kategori Sejajar (Lebar dibagi rata, Persis Figma)
        Row(
          children: List.generate(daftarKategori.length, (indeks) {
            final nama = daftarKategori[indeks]['nama'] as String;
            final ikon = daftarKategori[indeks]['ikon'] as IconData;
            final isDipilih = kategoriTerpilih.contains(nama);
            final isTerakhir = (indeks == daftarKategori.length - 1);

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (isDipilih) {
                      // Minimal satu kategori harus tetap terpilih
                      if (kategoriTerpilih.length > 1) {
                        kategoriTerpilih.remove(nama);
                      }
                    } else {
                      kategoriTerpilih.add(nama);
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 96,
                  margin: EdgeInsets.only(right: isTerakhir ? 0 : 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDipilih
                          ? const Color(0xFF0040A1)
                          : Colors.transparent,
                      width: 1.8,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDipilih
                            ? const Color(0xFF0040A1).withValues(alpha: 0.12)
                            : Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Kotak Ikon (40x40, borderRadius 14)
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isDipilih
                              ? const Color(0xFFEFF6FF)
                              : const Color(0xFFF3F4F5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          ikon,
                          color: isDipilih
                              ? const Color(0xFF0040A1)
                              : const Color(0xFF424654),
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        nama,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight:
                              isDipilih ? FontWeight.w700 : FontWeight.w600,
                          color: isDipilih
                              ? const Color(0xFF0040A1)
                              : const Color(0xFF424654),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ==========================================================
  // 4. WIDGET: ALAMAT & JADWAL PENJEMPUTAN (BENTO CARDS) (#293:1664)
  // ==========================================================
  Widget bagianAlamatDanJadwal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul Bagian
        Text(
          'ALAMAT',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF737785),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 14),

        // Kartu 1: Alamat Penjemputan (#293:1665)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 18,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ALAMAT PENJEMPUTAN',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF737785),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 10),

              // Baris Nama Tempat Kos
              Row(
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    color: Color(0xFF0040A1),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Kos',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF191C1D),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Detail Alamat Lengkap
              Text(
                'Kosan Harapan Indah, Kecamatan Sukapura,\nKabupaten Bandung, Jawa Barat 11530',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF424654),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),

              // Tombol Tautan Atur Alamat
              GestureDetector(
                onTap: () {
                  // Interaksi ubah alamat
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.edit_location_alt_outlined,
                      color: Color(0xFF0040A1),
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Atur Alamat',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0040A1),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Kartu 2: Jadwal Penjemputan (#293:1680)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 18,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'JADWAL PENJEMPUTAN',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF737785),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 10),

              // Tanggal & Ikon Kalender
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_rounded,
                    color: Color(0xFF0040A1),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Hari ini, 23 Oktober 2026',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF191C1D),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // Jam Penjemputan
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  '09.00 - 10.00 WIB',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF424654),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Tombol Tautan Atur Ulang Jadwal
              GestureDetector(
                onTap: () {
                  // Interaksi ubah jadwal
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      color: Color(0xFF0040A1),
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Atur Ulang',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0040A1),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // 5. WIDGET: CATATAN TAMBAHAN (OPSIONAL) (#293:1699)
  // ==========================================================
  Widget bagianCatatanTambahan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CATATAN TAMBAHAN (OPSIONAL)',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF737785),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 14),

        // Text Area Input Box Persis Figma (#740:1860)
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F5),
            borderRadius: BorderRadius.circular(24),
          ),
          child: TextField(
            controller: catatanController,
            maxLines: 4,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: const Color(0xFF191C1D),
            ),
            decoration: InputDecoration(
              hintText: 'Contoh: Tolong jangan pake pemutih',
              hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: const Color(0xFF737785),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(20),
              suffixIcon: const Padding(
                padding: EdgeInsets.all(16),
                child: Icon(
                  Icons.edit_note_rounded,
                  color: Color(0xFF737785),
                  size: 22,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // 6. WIDGET: BOTTOM BAR AKSI (ESTIMASI BIAYA + PESAN SEKARANG)
  // ==========================================================
  Widget bagianBawahAksi() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 32,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Baris Estimasi Biaya
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Estimasi Biaya',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF424654),
                ),
              ),
              Text(
                estimasiBiaya,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0040A1),
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Tombol Pesan Sekarang (#I310:2086;293:1731)
          GestureDetector(
            onTapDown: (_) {
              setState(() {
                skalaTombolAksi = 0.96;
              });
            },
            onTapUp: (_) {
              setState(() {
                skalaTombolAksi = 1.0;
              });
              // Pindah ke Halaman Konfirmasi (Pesanan Diterima!)
              keHalamanKonfirmasi();
            },
            onTapCancel: () {
              setState(() {
                skalaTombolAksi = 1.0;
              });
            },
            child: AnimatedScale(
              scale: skalaTombolAksi,
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeInOut,
              child: Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF0040A1),
                      Color(0xFF0056D2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(9999),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0040A1).withValues(alpha: 0.3),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pesan Sekarang',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Navigasi ke Halaman Konfirmasi Pesanan (Screen konfirmasi Remake)
  // pushReplacement: tombol back di halaman konfirmasi tidak kembali ke form
  void keHalamanKonfirmasi() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HalamanKonfirmasiPesanan(
          orderId: '#ZF-1202', // Dummy, sesuai Figma
          estimasiDijemput: '14:00 WIB', // Dummy, sesuai Figma
        ),
      ),
    );
  }
}
