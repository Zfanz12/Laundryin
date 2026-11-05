import 'dart:async';
import 'package:flutter/material.dart';

// warna
const Color biru = Color(0xFF0A4DB3);
const Color biruTerang = Color(0xFF0B63D6);
const Color bgApp = Color(0xFFF7F9FC);

// status pembayaran
enum StatusPembayaran { menunggu, diterima, gagal }

// data dummy
class DummyPembayaran {
  // ganti diterima / gagal buat ngetes
  static const StatusPembayaran hasilAkhir = StatusPembayaran.diterima;
  static const String alasanGagal = 'Nominal Tidak sesuai';
  static const String namaToko = 'Nama Toko Laundry nya';
}

// format 125000 -> 125.000
String formatRupiah(int angka) {
  return angka.toString().replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (match) => '.',
      );
}

// tombol biru
class TombolUtama extends StatelessWidget {
  final String teks;
  final VoidCallback onTap;
  final IconData? ikon;

  const TombolUtama({
    super.key,
    required this.teks,
    required this.onTap,
    this.ikon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [biru, biruTerang]),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: biru.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              teks,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            if (ikon != null) ...[
              const SizedBox(width: 6),
              Icon(ikon, color: Colors.white, size: 16),
            ],
          ],
        ),
      ),
    );
  }
}

// screen 1 - metode pembayaran
class MetodePembayaranScreen extends StatefulWidget {
  final String orderId;
  final int total;

  const MetodePembayaranScreen({
    super.key,
    required this.orderId,
    required this.total,
  });

  @override
  State<MetodePembayaranScreen> createState() => _MetodePembayaranScreenState();
}

class _MetodePembayaranScreenState extends State<MetodePembayaranScreen> {
  int terpilih = 0;

  // list metode
  final List<Map<String, dynamic>> metode = [
    {
      'nama': 'QRIS',
      'desc': 'Bayar menggunakan QRIS',
      'ikon': Icons.qr_code_scanner,
      'utama': true,
    },
    {
      'nama': 'Virtual Account',
      'desc': 'BCA, Mandiri, BNI, BRI, dll',
      'ikon': Icons.account_balance,
      'utama': false,
    },
    {
      'nama': 'E-Wallet',
      'desc': 'Gopay, Shopeepay, OVO, Dana',
      'ikon': Icons.account_balance_wallet_outlined,
      'utama': false,
    },
  ];

  void konfirmasiMetode() {
    // baru QRIS yang ada halamannya
    if (terpilih == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PembayaranQrisScreen(
            orderId: widget.orderId,
            total: widget.total,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Metode ini belum tersedia')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgApp,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: biru),
        title: const Text(
          'Metode Pembayaran',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // card metode
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: metode.length,
        itemBuilder: (context, i) {
          final item = metode[i];
          final aktif = terpilih == i;

          return GestureDetector(
            onTap: () => setState(() => terpilih = i),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: aktif ? biru : Colors.grey.shade200,
                  width: aktif ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  // ikon
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: bgApp,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(item['ikon'], color: Colors.black87, size: 22),
                  ),
                  const SizedBox(width: 12),
                  // nama & deskripsi
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              item['nama'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            // label utama
                            if (item['utama']) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE3EDFB),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'Utama',
                                  style: TextStyle(fontSize: 9, color: biru),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item['desc'],
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // centang
                  Icon(
                    aktif ? Icons.check_circle : Icons.circle_outlined,
                    color: aktif ? biru : Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // tombol bawah
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: TombolUtama(teks: 'Konfirmasi Metode', onTap: konfirmasiMetode),
      ),
    );
  }
}

// screen 2 - bayar pakai QRIS
class PembayaranQrisScreen extends StatefulWidget {
  final String orderId;
  final int total;

  const PembayaranQrisScreen({
    super.key,
    required this.orderId,
    required this.total,
  });

  @override
  State<PembayaranQrisScreen> createState() => _PembayaranQrisScreenState();
}

class _PembayaranQrisScreenState extends State<PembayaranQrisScreen> {
  bool sudahUpload = false;

  void konfirmasiPembayaran() {
    // wajib upload bukti (hapus kalau gak perlu)
    if (!sudahUpload) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Upload bukti pembayaran dulu ya')),
      );
      return;
    }

    // masuk ke status menunggu
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StatusPembayaranScreen(
          status: StatusPembayaran.menunggu,
          orderId: widget.orderId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgApp,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: biru),
        title: const Text(
          'Pembayaran',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // total harga
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'TOTAL HARGA',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              'Rp ${formatRupiah(widget.total)}',
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: biru,
              ),
            ),
          ),
          // order id
          Center(
            child: Text(
              'Order ID ${widget.orderId}',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 20),

          // card QR
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                const Text(
                  'Scan QRIS untuk bayar',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                // QR (placeholder)
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: bgApp,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.qr_code_2, size: 150),
                ),
                const SizedBox(height: 14),
                // nama toko
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.verified, color: biru, size: 16),
                    SizedBox(width: 6),
                    Text(
                      DummyPembayaran.namaToko,
                      style: TextStyle(fontSize: 12, color: biru),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // upload bukti
          GestureDetector(
            onTap: () => setState(() => sudahUpload = !sudahUpload),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    sudahUpload ? Icons.check_circle : Icons.upload_file,
                    color: biru,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    sudahUpload
                        ? 'bukti_pembayaran.jpg'
                        : 'Upload Bukti Pembayaran',
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // tombol bawah
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: TombolUtama(
          teks: 'Konfirmasi Pembayaran',
          onTap: konfirmasiPembayaran,
        ),
      ),
    );
  }
}

// screen 3 - status (tunggu / diterima / gagal)
class StatusPembayaranScreen extends StatefulWidget {
  final StatusPembayaran status;
  final String orderId;

  const StatusPembayaranScreen({
    super.key,
    required this.status,
    required this.orderId,
  });

  @override
  State<StatusPembayaranScreen> createState() => _StatusPembayaranScreenState();
}

class _StatusPembayaranScreenState extends State<StatusPembayaranScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();

    // simulasi verifikasi admin 3 detik
    if (widget.status == StatusPembayaran.menunggu) {
      timer = Timer(const Duration(seconds: 3), () {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => StatusPembayaranScreen(
              status: DummyPembayaran.hasilAkhir,
              orderId: widget.orderId,
            ),
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // ke beranda
  void keBeranda() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  // TODO: ganti ke DetailPesananScreen
  void keDetailPesanan() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    late Color warna;
    late IconData ikon;
    late String judul;
    late String deskripsi;

    // isi sesuai status
    switch (widget.status) {
      case StatusPembayaran.menunggu:
        warna = const Color(0xFFE6A800);
        ikon = Icons.access_time;
        judul = 'Tunggu ya!';
        deskripsi =
            'Admin kami sedang memverifikasi pembayaran anda\nanda bisa cek secara berkala';
        break;
      case StatusPembayaran.diterima:
        warna = biru;
        ikon = Icons.check;
        judul = 'Pembayaran Diterima!';
        deskripsi =
            'Pembayaran anda sudah diverifikasi,\nCucian anda sedang antre';
        break;
      case StatusPembayaran.gagal:
        warna = const Color(0xFFC00000);
        ikon = Icons.close;
        judul = 'Pembayaran Gagal!';
        deskripsi =
            'Pembayaran anda sudah di Verifikasi,\nnamun admin menyatakan pembayaran anda salah!';
        break;
    }

    final bool menunggu = widget.status == StatusPembayaran.menunggu;
    final bool gagal = widget.status == StatusPembayaran.gagal;

    return Scaffold(
      backgroundColor: bgApp,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // ikon status
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: warna,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: warna.withOpacity(0.4),
                      blurRadius: 40,
                      spreadRadius: 8,
                    ),
                  ],
                ),
                child: Icon(ikon, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 40),

              // judul & deskripsi
              Text(
                judul,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              Text(
                deskripsi,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: Colors.black54),
              ),
              const SizedBox(height: 30),

              // card order id / alasan
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      gagal ? 'Alasan' : 'Order ID',
                      style: const TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                    Text(
                      gagal ? DummyPembayaran.alasanGagal : widget.orderId,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 3),

              // tombol bawah
              if (menunggu)
                TextButton(
                  onPressed: keDetailPesanan,
                  child: const Text(
                    'Kembali ke Detail Pesanan',
                    style: TextStyle(color: biru, fontWeight: FontWeight.bold),
                  ),
                )
              else ...[
                TombolUtama(
                  teks: 'Detail Pesanan',
                  ikon: Icons.arrow_forward,
                  onTap: keDetailPesanan,
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: keBeranda,
                  child: const Text(
                    'Kembali ke Beranda',
                    style: TextStyle(color: biru, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
