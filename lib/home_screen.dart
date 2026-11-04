import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pesan_laundry_screen.dart';

// Halaman utama aplikasi LaundryIn
class HalamanUtama extends StatefulWidget {
  final VoidCallback? onKeProfil;

  const HalamanUtama({super.key, this.onKeProfil});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  // 0 untuk Tab 'Jenis', 1 untuk Tab 'Tipe'
  int tabLayananDipilih = 0;

  // Nilai skala tombol Pesan Sekarang saat ditekan (animasi press/hold)
  double skalaTombolPesan = 1.0;

  // Indeks kartu yang sedang ditekan untuk animasi sentuh
  int? indeksPesananDitekan;
  int? indeksLayananDitekan;

  // 1. Data Pesanan Aktif sesuai 1:1 dengan Figma (#678:3882)
  final List<Map<String, dynamic>> daftarPesananAktif = [
    {
      'id': '#ZF-1227',
      'status': 'MENUNGGU PEMBAYARAN',
      'warnaTitik': Color(0xFFFF9800), // Oranye
      'warnaLatarBadge': Color(0xFFFFF5E6),
      'warnaBorderBadge': Color(0xFFFFE0B2),
      'warnaGlow': Color(0xFFFF9800),
      'labelEstimasi': 'Estimasi Selesai',
      'waktu': '6 Jam',
      'progres': 0.15,
      'ikonJam': Color(0xFF8B5000),
    },
    {
      'id': '#ZF-1202',
      'status': 'SEDANG DIJEMPUT',
      'warnaTitik': Color(0xFFFF9800), // Oranye
      'warnaLatarBadge': Color(0xFFFFF5E6),
      'warnaBorderBadge': Color(0xFFFFE0B2),
      'warnaGlow': Color(0xFFFF9800),
      'labelEstimasi': 'Estimasi Sampai',
      'waktu': '15 Menit',
      'progres': 0.35,
      'ikonJam': Color(0xFF8B5000),
    },
    {
      'id': '#ZF-1200',
      'status': 'SEDANG DIANTAR',
      'warnaTitik': Color(0xFF03AF23), // Hijau
      'warnaLatarBadge': Color(0xFFF0FFF3),
      'warnaBorderBadge': Color(0xFFC8E6C9),
      'warnaGlow': Color(0xFF5CDF63),
      'labelEstimasi': 'Estimasi Sampai',
      'waktu': '7 Menit',
      'progres': 0.85,
      'ikonJam': Color(0xFF005312),
    },
    {
      'id': '#ZF-1234',
      'status': 'SEDANG DICUCI',
      'warnaTitik': Color(0xFF0056D2), // Biru
      'warnaLatarBadge': Color(0xFFE8F1FD),
      'warnaBorderBadge': Color(0xFFBBDEFB),
      'warnaGlow': Color(0xFF0056D2),
      'labelEstimasi': 'Estimasi Selesai',
      'waktu': '2 Jam',
      'progres': 0.60,
      'ikonJam': Color(0xFF0040A1),
    },
  ];

  // 2. Data Layanan 'Jenis' dengan Color Coding Persis Figma
  final List<Map<String, dynamic>> daftarLayananJenis = [
    {
      'nama': 'Regular',
      'deskripsi': 'Pencucian premium standar dalam 48 jam kerja.',
      'ikon': Icons.local_laundry_service_rounded,
      'gradient': const [Color(0xFF0040A1), Color(0xFF1C76FF)],
      'warnaShadow': Color(0xFF0040A1),
    },
    {
      'nama': 'Express',
      'deskripsi': 'Selesai dalam 24 jam. Cocok untuk kebutuhan mendesak.',
      'ikon': Icons.flash_on_rounded,
      'gradient': const [Color(0xFFFF9800), Color(0xFFFEC065)],
      'warnaShadow': Color(0xFFFF9800),
    },
    {
      'nama': 'Instant',
      'deskripsi': 'Layanan prioritas kilat. Selesai dalam 6 jam.',
      'ikon': Icons.rocket_launch_rounded,
      'gradient': const [Color(0xFF1C6D24), Color(0xFF36D346)],
      'warnaShadow': Color(0xFF1C6D24),
    },
  ];

  // 3. Data Layanan 'Tipe'
  final List<Map<String, dynamic>> daftarLayananTipe = [
    {
      'nama': 'Cuci + Gosok',
      'deskripsi': 'Dicuci bersih, disetrika rapi, siap langsung dipakai.',
      'ikon': Icons.dry_cleaning_rounded,
      'gradient': const [Color(0xFF0040A1), Color(0xFF1C76FF)],
      'warnaShadow': Color(0xFF0040A1),
    },
    {
      'nama': 'Cuci saja',
      'deskripsi': 'Pakaian dicuci bersih dan wangi, tanpa setrika.',
      'ikon': Icons.water_drop_rounded,
      'gradient': const [Color(0xFF0288D1), Color(0xFF4FC3F7)],
      'warnaShadow': Color(0xFF0288D1),
    },
    {
      'nama': 'Gosok saja',
      'deskripsi': 'Setrika rapi untuk pakaian yang sudah dicuci di rumah.',
      'ikon': Icons.iron_rounded,
      'gradient': const [Color(0xFFE65100), Color(0xFFFFB74D)],
      'warnaShadow': Color(0xFFE65100),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header (Salam & Profil Pengguna)
              bagianHeader(),
              const SizedBox(height: 24),

              // 2. Hero Section (Banner Promo Pesan Sekarang dengan Glow Effect)
              bagianHeroBanner(),
              const SizedBox(height: 28),

              // 3. Pesanan Aktif (Kartu dengan Status Pill & Glow Sesuai Figma)
              bagianPesananAktif(),
              const SizedBox(height: 28),

              // 4. Layanan (Segmented Control + Kartu dengan Color Coding Persis)
              bagianLayanan(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // 1. Widget Header Selamat Datang
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
            const SizedBox(height: 2),
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
        // Foto profil pengguna yang bisa diklik untuk pindah ke tab profil
        GestureDetector(
          onTap: widget.onKeProfil,
          child: Container(
            width: 48,
            height: 48,
            padding: const EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF1867D5),
                width: 2,
              ),
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
                      size: 24,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 2. Widget Hero Section dengan Gradient (Kiri ke Kanan Lebih Terang, Tanpa Lingkaran)
  Widget bagianHeroBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0040A1), // Sisi kiri: Biru tua elegan
            Color(0xFF1E7BFF), // Sisi kanan: Lebih terang & menyala
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF004AB3).withValues(alpha: 0.50),
            blurRadius: 36,
            offset: const Offset(0, 16),
            spreadRadius: -8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            // Pola gambar background asli dari Figma
            Positioned.fill(
              child: Opacity(
                opacity: 0.12,
                child: Image.asset(
                  'assets/images/banner_bg-2f67e1.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(),
                ),
              ),
            ),
            // Konten teks dan tombol
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pesan laundry\nantar - jemput\nsekarang!',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.22,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Tombol Pesan Sekarang dengan animasi interaksi sentuh/hold
                  GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        skalaTombolPesan = 0.94;
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        skalaTombolPesan = 1.0;
                      });
                      // Navigasi langsung ke Halaman Pesan Laundry tanpa popup
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HalamanPesanLaundry(),
                        ),
                      );
                    },
                    onTapCancel: () {
                      setState(() {
                        skalaTombolPesan = 1.0;
                      });
                    },
                    child: AnimatedScale(
                      scale: skalaTombolPesan,
                      duration: const Duration(milliseconds: 140),
                      curve: Curves.easeOutCubic,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9999),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.35),
                              blurRadius: 9.6,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Pesan Sekarang',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0040A1),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 18,
                              color: Color(0xFF0040A1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 3. Widget Pesanan Aktif (Horizontal Scroll, Status Badge Dot & Glow Persis Figma)
  Widget bagianPesananAktif() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Pesanan Aktif',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF191C1D),
                letterSpacing: -0.3,
              ),
            ),
            Text(
              'Geser untuk lihat',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF8F8F8F),
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        // List horizontal kartu pesanan
        SizedBox(
          height: 154,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: daftarPesananAktif.length,
            separatorBuilder: (context, index) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final pesanan = daftarPesananAktif[index];
              return itemKartuPesananFigma(pesanan, index);
            },
          ),
        ),
      ],
    );
  }

  // Kartu Pesanan Aktif dengan Glow dan Animasi Sentuh Tanpa SnackBar
  Widget itemKartuPesananFigma(Map<String, dynamic> pesanan, int index) {
    final Color warnaGlow = pesanan['warnaGlow'] as Color;
    final Color warnaTitik = pesanan['warnaTitik'] as Color;
    final Color warnaLatarBadge = pesanan['warnaLatarBadge'] as Color;
    final Color warnaBorderBadge = pesanan['warnaBorderBadge'] as Color;
    final bool sedangDitekan = (indeksPesananDitekan == index);

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          indeksPesananDitekan = index;
        });
      },
      onTapUp: (_) {
        setState(() {
          indeksPesananDitekan = null;
        });
      },
      onTapCancel: () {
        setState(() {
          indeksPesananDitekan = null;
        });
      },
      child: AnimatedScale(
        scale: sedangDitekan ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInOut,
        child: Container(
          width: 325,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Stack(
              children: [
                // Efek Ambient Glow di pojok kanan atas kartu sesuai Figma
                Positioned(
                  top: -35,
                  right: -25,
                  child: Container(
                    width: 125,
                    height: 125,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          warnaGlow.withValues(alpha: 0.28),
                          warnaGlow.withValues(alpha: 0.10),
                          warnaGlow.withValues(alpha: 0.0),
                        ],
                        stops: const [0.0, 0.45, 1.0],
                      ),
                    ),
                  ),
                ),
                // Konten Kartu
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Baris Atas: ID Pesanan & Status Pill dengan Dot Berwarna
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pesanan['id'] as String,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF191C1D),
                            ),
                          ),
                          // Status Badge Persis Figma (Dot + Teks)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: warnaLatarBadge,
                              borderRadius: BorderRadius.circular(9999),
                              border: Border.all(
                                color: warnaBorderBadge,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Dot indikator berwarna (width 8, height 8)
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: warnaTitik,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  pesanan['status'] as String,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF191C1D),
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(9999),
                        child: LinearProgressIndicator(
                          value: pesanan['progres'] as double,
                          minHeight: 6,
                          backgroundColor: const Color(0xFFE1E3E4),
                          valueColor: AlwaysStoppedAnimation<Color>(warnaTitik),
                        ),
                      ),

                      // Baris Bawah: Ikon Jam & Estimasi Waktu
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 15,
                            color: pesanan['ikonJam'] as Color,
                          ),
                          const SizedBox(width: 6),
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: const Color(0xFF424654),
                              ),
                              children: [
                                TextSpan(
                                  text: '${pesanan['labelEstimasi']}: ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: pesanan['waktu'] as String,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 4. Widget Bagian Layanan (Segmented Control & Color Coding Persis Figma)
  Widget bagianLayanan() {
    final listLayanan =
        (tabLayananDipilih == 0) ? daftarLayananJenis : daftarLayananTipe;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ada layanan apa aja sih?',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF191C1D),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 16),

        // Segmented Control (Pilihan Tab Jenis dan Tipe)
        Center(
          child: Container(
            width: 270,
            height: 40,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F5),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Stack(
              children: [
                // Kapsul putih bergeser halus saat tab ditekan
                AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  alignment: (tabLayananDipilih == 0)
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    width: 130,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                // Tombol Tab Jenis dan Tipe
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            tabLayananDipilih = 0;
                          });
                        },
                        child: Center(
                          child: Text(
                            'Jenis',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: (tabLayananDipilih == 0)
                                  ? const Color(0xFF0040A1)
                                  : const Color(0xFF646E77),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            tabLayananDipilih = 1;
                          });
                        },
                        child: Center(
                          child: Text(
                            'Tipe',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: (tabLayananDipilih == 1)
                                  ? const Color(0xFF0040A1)
                                  : const Color(0xFF646E77),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),

        // Daftar Kartu Layanan (Sesuai Layout Vertikal Figma EL-de3c2715)
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listLayanan.length,
          separatorBuilder: (context, index) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final item = listLayanan[index];
            return itemKartuLayananFigma(item, index);
          },
        ),
      ],
    );
  }

  // Kartu Layanan Vertikal Persis Figma (EL-de3c2715) dengan Animasi Sentuh Tanpa SnackBar
  Widget itemKartuLayananFigma(Map<String, dynamic> item, int index) {
    final gradient = item['gradient'] as List<Color>;
    final warnaShadow = item['warnaShadow'] as Color;
    final bool sedangDitekan = (indeksLayananDitekan == index);

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          indeksLayananDitekan = index;
        });
      },
      onTapUp: (_) {
        setState(() {
          indeksLayananDitekan = null;
        });
      },
      onTapCancel: () {
        setState(() {
          indeksLayananDitekan = null;
        });
      },
      child: AnimatedScale(
        scale: sedangDitekan ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInOut,
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
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
              // Kotak Logo Icon dengan Gradient Warna Sesuai Layanan
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradient,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: warnaShadow.withValues(alpha: 0.30),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  item['ikon'] as IconData,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(height: 14),
              // Judul Layanan
              Text(
                item['nama'] as String,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF191C1D),
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 4),
              // Deskripsi Layanan
              Text(
                item['deskripsi'] as String,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFA3A3A3),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
