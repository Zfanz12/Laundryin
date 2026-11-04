import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HalamanDetailPesanan extends StatelessWidget {
  final Map<String, dynamic> pesanan;

  const HalamanDetailPesanan({super.key, required this.pesanan});

  static const Color warnaBiru = Color(0xFF0040A1);
  static const Color warnaTeksGelap = Color(0xFF191C1D);
  static const Color warnaTeksAbu = Color(0xFF737785);
  static const Color warnaTeksMuda = Color(0xFF9AA0A6);
  static const Color warnaHijau = Color(0xFF2E7D32);
  static const Color warnaOranye = Color(0xFFFF9800);
  static const Color warnaCokelat = Color(0xFF8B5000);
  static const Color warnaGaris = Color(0xFFE1E3E4);

  static const int ongkosKirim = 5000;

  static const List<Map<String, String>> daftarTahapan = [
    {'judul': 'Penjemputan Cucian', 'keterangan': 'Hari ini, 09:00 WIB'},
    {'judul': 'Penghitungan Cucian', 'keterangan': 'Hari ini, 09:00 WIB'},
    {'judul': 'Pembayaran Cucian', 'keterangan': 'Hari ini, 09:00 WIB'},
    {'judul': 'Menunggu Antrean', 'keterangan': 'Hari ini, 09:00 WIB'},
    {'judul': 'Sedang Dicuci', 'keterangan': 'Estimasi selesai 14:00 WIB'},
    {'judul': 'Pengantaran', 'keterangan': 'Menunggu proses cucian selesai'},
    {'judul': 'Cucian Sampai', 'keterangan': 'Menunggu proses cucian selesai'},
  ];

  static const Map<String, int> tahapAktifPerStatus = {
    'DIJEMPUT': 0,
    'DIHITUNG': 1,
    'BAYAR': 2,
    'ANTREAN': 3,
    'DICUCI': 4,
    'DIANTAR': 5,
    'SELESAI': 7,
  };

  static const Map<String, String> labelStatus = {
    'BAYAR': 'PEMBAYARAN',
    'ANTREAN': 'MENGANTRE',
  };

  static const Map<String, List<List<String>>> rincianKhusus = {
    '#ZF-1227': [
      ['Celana', '7'],
      ['Kaos Kaki', '1'],
      ['Leggings', '1'],
      ['Selimut', '1'],
    ],
  };

  String get status => pesanan['status'] as String;
  bool get hijau => pesanan['hijau'] as bool;
  bool get menungguBayar => status == 'BAYAR';
  int get tahapAktif => tahapAktifPerStatus[status] ?? 0;

  List<String> get daftarAksi =>
      ((pesanan['aksi'] as List?) ?? const []).cast<String>();

  int? get totalHarga {
    final String? harga = pesanan['harga'] as String?;
    if (harga == null) return null;
    return int.tryParse(harga.replaceAll(RegExp(r'[^0-9]'), ''));
  }

  String get beratTampil {
    final String berat = pesanan['berat'] as String;
    if (berat == '~') return 'Belum dihitung...';
    return berat;
  }

  bool get beratBelumAda {
    final String berat = pesanan['berat'] as String;
    return berat == '~' || berat.startsWith('sedang');
  }

  List<List<String>> get daftarRincian {
    final String id = pesanan['id'] as String;
    if (rincianKhusus.containsKey(id)) return rincianKhusus[id]!;

    final String teks = pesanan['item'] as String;
    if (teks.startsWith('sedang')) return [];

    final List<List<String>> hasil = [];
    for (final String bagian in teks.split(RegExp(r'[•,]'))) {
      final String isi = bagian.trim();
      if (isi.isEmpty) continue;

      final int spasi = isi.indexOf(' ');
      final String angka = spasi > 0 ? isi.substring(0, spasi) : '';
      if (int.tryParse(angka) != null) {
        hasil.add([isi.substring(spasi + 1), angka]);
      } else {
        hasil.add([isi, '~']);
      }
    }
    return hasil;
  }

  String formatRupiah(int nilai) {
    final String angka = nilai.toString();
    final StringBuffer hasil = StringBuffer();
    for (int i = 0; i < angka.length; i++) {
      if (i > 0 && (angka.length - i) % 3 == 0) hasil.write('.');
      hasil.write(angka[i]);
    }
    return 'Rp $hasil';
  }

  @override
  Widget build(BuildContext context) {
    final double lebarLayar = MediaQuery.sizeOf(context).width;
    final double jarakSamping = lebarLayar < 360 ? 16 : 24;
    final double jarakBawahHp = MediaQuery.paddingOf(context).bottom;

    final TextScaler skalaHuruf = MediaQuery.textScalerOf(
      context,
    ).clamp(maxScaleFactor: 1.3);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: skalaHuruf),
        child: Scaffold(
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
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: jarakSamping - 10,
                    vertical: 6,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: const SizedBox(
                          width: 44,
                          height: 44,
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: Color(0xFF1D4ED8),
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Detail Order',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                            letterSpacing: -0.4,
                          ),
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
            padding: EdgeInsets.fromLTRB(
              jarakSamping,
              20,
              jarakSamping,
              32 + jarakBawahHp,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                kartuStatus(),
                const SizedBox(height: 20),

                if (menungguBayar) ...[
                  kartuPembayaran(),
                  const SizedBox(height: 20),
                ],

                kartuLinimasa(),
                const SizedBox(height: 20),

                kartuRincian(),

                if (!menungguBayar) ...[
                  const SizedBox(height: 20),
                  kartuPembayaran(),
                ],
                const SizedBox(height: 20),

                Center(
                  child: GestureDetector(
                    onTap: () {},
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Text(
                        'Butuh Bantuan?',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: warnaBiru,
                          decoration: TextDecoration.underline,
                          decorationColor: warnaBiru,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration dekorasiKartu() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(28),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 18,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Widget judulKartu(String judul) {
    return Text(
      judul,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: warnaTeksGelap,
        letterSpacing: -0.3,
      ),
    );
  }

  Widget kartuStatus() {
    final double? progres = pesanan['progres'] as double?;
    final Color warnaGlow = hijau ? const Color(0xFF5CDF63) : warnaOranye;

    return Container(
      decoration: dekorasiKartu(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
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

            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ID PESANAN',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: warnaTeksAbu,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              pesanan['id'] as String,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: warnaTeksGelap,
                                letterSpacing: -0.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      badgeStatus(),
                    ],
                  ),
                  const SizedBox(height: 14),
                  barisInfo(
                    Icons.checkroom_rounded,
                    pesanan['item'] as String,
                    redup: (pesanan['item'] as String).startsWith('sedang'),
                  ),
                  const SizedBox(height: 8),
                  barisInfo(
                    Icons.shopping_bag_outlined,
                    beratTampil,
                    redup: beratBelumAda,
                  ),

                  if (progres != null) ...[
                    const SizedBox(height: 18),
                    progressBar(progres),
                    const SizedBox(height: 14),
                    barisEstimasi(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget badgeStatus() {
    final Color warnaTitik = hijau ? const Color(0xFF03AF23) : warnaOranye;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: const Color(0xFFEDEEF0)),
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
          const SizedBox(width: 8),
          Text(
            labelStatus[status] ?? status,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: warnaTeksGelap,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget barisInfo(IconData ikon, String teks, {bool redup = false}) {
    return Row(
      children: [
        Icon(ikon, size: 17, color: warnaTeksAbu),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            teks,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: redup ? warnaTeksMuda : warnaTeksAbu,
            ),
          ),
        ),
      ],
    );
  }

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
            gradient: const LinearGradient(
              colors: [Color(0xFF0040A1), Color(0xFF0056D2)],
            ),
            borderRadius: BorderRadius.circular(9999),
          ),
        ),
      ),
    );
  }

  Widget barisEstimasi() {
    final String label =
        (pesanan['estimasiLabel'] as String?) ?? 'Estimasi Selesai';
    final String nilai = (pesanan['estimasi'] as String?) ?? '~';

    return Row(
      children: [
        const Icon(Icons.schedule_rounded, size: 15, color: warnaCokelat),
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

  Widget kartuLinimasa() {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 12, 14, 14),
      decoration: dekorasiKartu(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 44,
            child: Row(
              children: [
                Expanded(child: judulKartu('Linimasa Pesanan')),
                if (daftarAksi.contains('Track'))
                  GestureDetector(
                    onTap: () {},
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 10,
                      ),
                      child: Text(
                        'Track',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: warnaBiru,
                          decoration: TextDecoration.underline,
                          decorationColor: warnaBiru,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          for (int i = 0; i < daftarTahapan.length; i++) barisTahapan(i),
        ],
      ),
    );
  }

  Widget barisTahapan(int index) {
    final bool selesai = index < tahapAktif;
    final bool aktif = index == tahapAktif;
    final bool terakhir = index == daftarTahapan.length - 1;
    final Map<String, String> tahap = daftarTahapan[index];

    Color warnaJudul = const Color(0xFF424754);
    FontWeight tebalJudul = FontWeight.w500;
    if (aktif) {
      warnaJudul = warnaCokelat;
      tebalJudul = FontWeight.w700;
    } else if (selesai) {
      warnaJudul = warnaTeksGelap;
      tebalJudul = FontWeight.w600;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 28,
            child: Column(
              children: [
                indikatorTahapan(selesai, aktif),
                if (!terakhir)
                  Expanded(child: Container(width: 2, color: warnaGaris)),
              ],
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 2, bottom: terakhir ? 8 : 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tahap['judul']!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: tebalJudul,
                      color: warnaJudul,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tahap['keterangan']!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: warnaTeksMuda,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget indikatorTahapan(bool selesai, bool aktif) {
    if (selesai) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: warnaHijau,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: const Icon(Icons.check_rounded, size: 14, color: Colors.white),
      );
    }

    if (aktif) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: warnaOranye,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: warnaOranye.withValues(alpha: 0.35),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF5A3300),
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }

    return Container(
      width: 22,
      height: 22,
      margin: const EdgeInsets.all(1),
      decoration: const BoxDecoration(
        color: Color(0xFFDADCE0),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget kartuRincian() {
    final List<List<String>> rincian = daftarRincian;
    final String totalBerat = beratBelumAda ? '~' : pesanan['berat'] as String;

    return Container(
      decoration: dekorasiKartu(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
            child: Row(
              children: [
                Expanded(child: judulKartu('Rincian Pakaian')),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total berat',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: warnaTeksAbu,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          totalBerat,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: warnaBiru,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.shopping_bag_outlined,
                          size: 18,
                          color: warnaBiru,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(height: 1, color: const Color(0xFFF0F1F2)),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
            child: rincian.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Rincian pakaian sedang dihitung...',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: warnaTeksMuda,
                      ),
                    ),
                  )
                : Column(
                    children: rincian
                        .map((item) => kartuItemPakaian(item[0], item[1]))
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }

  IconData ikonPakaian(String nama) {
    if (nama == 'Baju') return Icons.checkroom_rounded;
    if (nama == 'Celana' ||
        nama == 'Lainnya' ||
        nama == 'Sprei' ||
        nama == 'Seprei') {
      return Icons.dry_cleaning_rounded;
    }
    return Icons.more_horiz_rounded;
  }

  Widget kartuItemPakaian(String nama, String jumlah) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              ikonPakaian(nama),
              size: 20,
              color: const Color(0xFF424754),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              nama,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: warnaTeksGelap,
              ),
            ),
          ),
          Text(
            jumlah == '~' ? '~' : '$jumlah×',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: warnaTeksGelap,
            ),
          ),
        ],
      ),
    );
  }

  Widget kartuPembayaran() {
    final int? total = totalHarga;
    final String teksSubtotal = total == null
        ? 'Rp ~'
        : formatRupiah(total - ongkosKirim);
    final String teksDelivery = total == null
        ? 'Rp ~'
        : formatRupiah(ongkosKirim);
    final String teksTotal = total == null ? 'Rp ~' : formatRupiah(total);

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: dekorasiKartu(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          judulKartu('Ringkasan Pembayaran'),
          const SizedBox(height: 16),
          barisHarga('Subtotal', teksSubtotal),
          const SizedBox(height: 12),
          barisHarga('Delivery', teksDelivery),
          const SizedBox(height: 14),
          Container(height: 1, color: const Color(0xFFF0F1F2)),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: warnaTeksGelap,
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    teksTotal,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: warnaBiru,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [metodePembayaran(), tombolPembayaran(total != null)],
          ),
        ],
      ),
    );
  }

  Widget barisHarga(String label, String nilai) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: warnaTeksAbu,
          ),
        ),
        Text(
          nilai,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: warnaTeksGelap,
          ),
        ),
      ],
    );
  }

  Widget metodePembayaran() {
    return Container(
      padding: menungguBayar
          ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
          : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: menungguBayar ? Border.all(color: warnaGaris) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.qr_code_2_rounded, size: 22, color: warnaTeksGelap),
          const SizedBox(width: 8),
          Text(
            'QRIS',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: warnaTeksGelap,
            ),
          ),
        ],
      ),
    );
  }

  Widget tombolPembayaran(bool hargaSudahAda) {
    // Menunggu pembayaran -> tombol BAYAR biru
    if (menungguBayar) {
      return GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0040A1), Color(0xFF0056D2)],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: warnaBiru.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            'BAYAR',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: warnaGaris),
      ),
      child: Text(
        hargaSudahAda ? 'LUNAS' : 'BAYAR',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: hargaSudahAda
              ? const Color(0xFF0056D2)
              : const Color(0xFFC4C7CC),
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
