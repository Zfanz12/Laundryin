import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'alamat_screen.dart';

class HalamanPesanLaundry extends StatefulWidget {
  const HalamanPesanLaundry({super.key});

  @override
  State<HalamanPesanLaundry> createState() => _HalamanPesanLaundryState();
}

class _HalamanPesanLaundryState extends State<HalamanPesanLaundry> {
  int jenisLayananDipilih = 0;
  int kecepatanDipilih = 1;
  final Set<String> kategoriTerpilih = {'Pakaian'};
  final TextEditingController catatanController = TextEditingController();
  double skalaTombolAksi = 1.0;
  String namaAlamat = 'Kos';
  String detailAlamat =
      'Kosan Harapan Indah, Kecamatan Sukapura,\nKabupaten Bandung, Jawa Barat 11530';

  Future<void> bukaAturAlamat() async {
    final AddressModel? alamatDipilih = await Navigator.push<AddressModel>(
      context,
      MaterialPageRoute(builder: (context) => const AddressListScreen()),
    );
    if (alamatDipilih != null && mounted) {
      setState(() {
        namaAlamat = alamatDipilih.label;
        detailAlamat = alamatDipilih.fullAddress;
      });
    }
  }

  String get minHarga {
    if (kecepatanDipilih == 0) {
      return 'Rp 45.000';
    } else if (kecepatanDipilih == 1) {
      return 'Rp 65.000';
    } else {
      return 'Rp 95.000';
    }
  }

  String get estimasiBiaya => 'Biaya mulai dari $minHarga';

  @override
  void dispose() {
    catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bagianJenisLayanan(),
            const SizedBox(height: 32),
            bagianKecepatanLayanan(),
            const SizedBox(height: 32),
            bagianKategoriItem(),
            const SizedBox(height: 32),
            bagianAlamatDanJadwal(),
            const SizedBox(height: 32),
            bagianCatatanTambahan(),
          ],
        ),
      ),
      bottomSheet: bagianBawahAksi(),
    );
  }

  Widget bagianJenisLayanan() {
    final daftarJenis = ['Cuci Gosok', 'Gosok Saja', 'Cuci Saja'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                          fontWeight: isDipilih
                              ? FontWeight.w700
                              : FontWeight.w600,
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
        kartuKecepatan(
          indeks: 0,
          nama: 'Reguler',
          deskripsi: '48 jam pengerjaan',
          ikon: Icons.access_time_rounded,
          warnaGradient: const [Color(0xFF0E63DE), Color(0xFF1469E3)],
          warnaGlow: const Color(0xFF0F64DF),
        ),
        const SizedBox(height: 14),
        kartuKecepatan(
          indeks: 1,
          nama: 'Ekspres',
          deskripsi: '24 jam pengerjaan',
          ikon: Icons.flash_on_rounded,
          warnaGradient: const [Color(0xFFF3BB01), Color(0xFFF6C601)],
          warnaGlow: const Color(0xFFF3BB01),
        ),
        const SizedBox(height: 14),
        kartuKecepatan(
          indeks: 2,
          nama: 'Instan',
          deskripsi: '6 jam pengerjaan',
          ikon: Icons.rocket_launch_rounded,
          warnaGradient: const [Color(0xFF2BBC3B), Color(0xFF33C243)],
          warnaGlow: const Color(0xFF2BBC3B),
        ),
      ],
    );
  }

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isDipilih
                            ? Colors.white
                            : const Color(0xFF191C1D),
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
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDipilih ? Colors.white : Colors.transparent,
                  border: Border.all(
                    color: isDipilih ? Colors.white : const Color(0xFFE7E8E9),
                    width: 2.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bagianKategoriItem() {
    final daftarKategori = [
      {'nama': 'Pakaian', 'ikon': Icons.checkroom_rounded},
      {'nama': 'Sepatu', 'ikon': Icons.roller_skating_rounded},
      {'nama': 'Seprai', 'ikon': Icons.bed_rounded},
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: daftarKategori.map((item) {
              final nama = item['nama'] as String;
              final ikon = item['ikon'] as IconData;
              final isDipilih = kategoriTerpilih.contains(nama);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isDipilih) {
                      if (kategoriTerpilih.length > 1) {
                        kategoriTerpilih.remove(nama);
                      }
                    } else {
                      kategoriTerpilih.add(nama);
                    }
                  });
                },
                child: Container(
                  width: 128,
                  height: 112,
                  margin: const EdgeInsets.only(right: 9),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: isDipilih
                        ? Border.all(color: const Color(0xFF0040A1), width: 1.8)
                        : null,
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
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isDipilih
                              ? const Color(0xFFEFF6FF)
                              : const Color(0xFFF3F4F5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          ikon,
                          color: isDipilih
                              ? const Color(0xFF0040A1)
                              : const Color(0xFF424654),
                          size: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        nama,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: isDipilih
                              ? FontWeight.w700
                              : FontWeight.w600,
                          color: isDipilih
                              ? const Color(0xFF0040A1)
                              : const Color(0xFF424654),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget bagianAlamatDanJadwal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alamat',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF737785),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 14),
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
              Row(
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    color: Color(0xFF0040A1),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    namaAlamat,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF191C1D),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                detailAlamat,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF424654),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: bukaAturAlamat,
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
              GestureDetector(
                onTap: () {},
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
              hintText: 'Contoh: Tolong jangan pakai pemutih',
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

  Widget bagianBawahAksi() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Biaya mulai dari :',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF424654),
                ),
              ),
              Text(
                minHarga,
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
          GestureDetector(
            onTapDown: (_) {
              setState(() {
                skalaTombolAksi = 0.94;
              });
            },
            onTapUp: (_) {
              setState(() {
                skalaTombolAksi = 1.0;
              });
              tampilkanModalKonfirmasiPesanan();
            },
            onTapCancel: () {
              setState(() {
                skalaTombolAksi = 1.0;
              });
            },
            child: AnimatedScale(
              scale: skalaTombolAksi,
              duration: const Duration(milliseconds: 140),
              curve: Curves.easeOutCubic,
              child: Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0040A1), Color(0xFF0056D2)],
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

  void tampilkanModalKonfirmasiPesanan() {
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
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF0040A1),
                  size: 34,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Pesanan Siap Dibuat!',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF191C1D),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Kurir LaundryIn akan menjemput cucian ke Kosan Harapan Indah sesuai jadwal.',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: const Color(0xFF737785),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0040A1),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Kembali ke Beranda',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
