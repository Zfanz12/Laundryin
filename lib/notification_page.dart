import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum JenisNotifikasi { pembayaran, proses, promo, selesai, kurir }

class ItemNotifikasi {
  final JenisNotifikasi jenis;
  final String judul;
  final String pesan;
  final String waktu;
  final String kelompok;
  bool sudahDibaca;

  ItemNotifikasi({
    required this.jenis,
    required this.judul,
    required this.pesan,
    required this.waktu,
    required this.kelompok,
    this.sudahDibaca = false,
  });
}

class HalamanNotifikasi extends StatefulWidget {
  const HalamanNotifikasi({super.key});

  @override
  State<HalamanNotifikasi> createState() => _HalamanNotifikasiState();
}

class _HalamanNotifikasiState extends State<HalamanNotifikasi> {
  static const Color _biru = Color(0xFF0040A1);
  static const Color _latar = Color(0xFFF8F9FA);

  final List<ItemNotifikasi> _daftar = [
    ItemNotifikasi(
      jenis: JenisNotifikasi.pembayaran,
      judul: 'Anda belum melakukan pembayaran!',
      pesan:
          'Order #ZF-1227 sudah ditimbang, segera lakukan pembayaran untuk berlanjut ke tahap selanjutnya!',
      waktu: '10 menit yang lalu',
      kelompok: 'Prioritas utama',
    ),
    ItemNotifikasi(
      jenis: JenisNotifikasi.proses,
      judul: 'Cucianmu Sedang Dicuci',
      pesan:
          'Order #ZF-1234 sedang dalam proses pencucian dengan deterjen premium.',
      waktu: '10 menit yang lalu',
      kelompok: 'Hari Ini',
    ),
    ItemNotifikasi(
      jenis: JenisNotifikasi.promo,
      judul: 'Promo Khusus Weekend!',
      pesan: 'Dapatkan diskon 20% untuk layanan Express weekend saja',
      waktu: '2 jam yang lalu',
      kelompok: 'Hari Ini',
    ),
    ItemNotifikasi(
      jenis: JenisNotifikasi.selesai,
      judul: 'Pesanan Selesai',
      pesan: 'Order #ZF-0101 telah selesai dan siap diambil atau diantar.',
      waktu: '3 hari yang lalu',
      kelompok: 'Minggu Ini',
      sudahDibaca: true,
    ),
    ItemNotifikasi(
      jenis: JenisNotifikasi.kurir,
      judul: 'Kurir Menuju Lokasimu',
      pesan:
          'Kurir kami sedang dalam perjalanan untuk menjemput cucianmu (Order #ZF-5173).',
      waktu: '5 hari yang lalu',
      kelompok: 'Minggu Ini',
      sudahDibaca: true,
    ),
    ItemNotifikasi(
      jenis: JenisNotifikasi.selesai,
      judul: 'Pesanan Selesai',
      pesan: 'Order #ZF-0101 telah selesai dan siap diambil atau diantar.',
      waktu: '3 hari yang lalu',
      kelompok: 'Minggu Ini',
      sudahDibaca: true,
    ),
    ItemNotifikasi(
      jenis: JenisNotifikasi.kurir,
      judul: 'Kurir Menuju Lokasimu',
      pesan:
          'Kurir kami sedang dalam perjalanan untuk menjemput cucianmu (Order #ZF-5173).',
      waktu: '5 hari yang lalu',
      kelompok: 'Minggu Ini',
      sudahDibaca: true,
    ),
  ];

  List<String> get _daftarKelompok {
    final hasil = <String>[];
    for (final item in _daftar) {
      if (!hasil.contains(item.kelompok)) hasil.add(item.kelompok);
    }
    return hasil;
  }

  void _tandaiSemuaDibaca() {
    setState(() {
      for (final item in _daftar) {
        item.sudahDibaca = true;
      }
    });
  }

  void _tandaiDibaca(ItemNotifikasi item) {
    if (item.sudahDibaca) return;
    setState(() {
      item.sudahDibaca = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final kelompok = _daftarKelompok;

    return Scaffold(
      backgroundColor: _latar,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        title: Text(
          'Notifikasi',
          style: GoogleFonts.plusJakartaSans(
            color: _biru,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Tandai semua dibaca',
            onPressed: _tandaiSemuaDibaca,
            icon: const Icon(Icons.done_all_rounded, color: _biru, size: 22),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _daftar.isEmpty
          ? const _TampilanKosong()
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              itemCount: kelompok.length,
              itemBuilder: (context, index) {
                final namaKelompok = kelompok[index];
                final itemKelompok = _daftar
                    .where((e) => e.kelompok == namaKelompok)
                    .toList();

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          namaKelompok,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      ...itemKelompok.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _KartuNotifikasi(
                            item: item,
                            onTap: () => _tandaiDibaca(item),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class _KartuNotifikasi extends StatelessWidget {
  final ItemNotifikasi item;
  final VoidCallback onTap;

  const _KartuNotifikasi({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final gaya = _gayaJenis(item.jenis);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 1.5,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: gaya.latar,
                  shape: BoxShape.circle,
                ),
                child: Icon(gaya.ikon, color: gaya.warna, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: Text(
                        item.judul,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.pesan,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.5,
                        height: 1.45,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF5F6368),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.waktu,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF9AA0A6),
                      ),
                    ),
                  ],
                ),
              ),
              if (!item.sudahDibaca)
                Container(
                  margin: const EdgeInsets.only(left: 6, top: 2),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0040A1),
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _GayaJenis _gayaJenis(JenisNotifikasi jenis) {
    switch (jenis) {
      case JenisNotifikasi.pembayaran:
        return const _GayaJenis(
          ikon: Icons.receipt_long_rounded,
          warna: Color(0xFFD93025),
          latar: Color(0xFFFDECEA),
        );
      case JenisNotifikasi.proses:
        return const _GayaJenis(
          ikon: Icons.local_laundry_service_rounded,
          warna: Color(0xFFF29900),
          latar: Color(0xFFFEF3DC),
        );
      case JenisNotifikasi.promo:
        return const _GayaJenis(
          ikon: Icons.card_giftcard_rounded,
          warna: Color(0xFF0040A1),
          latar: Color(0xFFE6EEFB),
        );
      case JenisNotifikasi.selesai:
        return const _GayaJenis(
          ikon: Icons.check_circle_rounded,
          warna: Color(0xFF2E7D32),
          latar: Color(0xFFE6F4E7),
        );
      case JenisNotifikasi.kurir:
        return const _GayaJenis(
          ikon: Icons.local_shipping_rounded,
          warna: Color(0xFF5F6368),
          latar: Color(0xFFEDEFF1),
        );
    }
  }
}

class _GayaJenis {
  final IconData ikon;
  final Color warna;
  final Color latar;

  const _GayaJenis({
    required this.ikon,
    required this.warna,
    required this.latar,
  });
}

class _TampilanKosong extends StatelessWidget {
  const _TampilanKosong();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.notifications_none_rounded,
            size: 56,
            color: Color(0xFF9AA0A6),
          ),
          const SizedBox(height: 12),
          Text(
            'Belum ada notifikasi',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF5F6368),
            ),
          ),
        ],
      ),
    );
  }
}