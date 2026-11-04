import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ====================================================================
// HALAMAN KONFIRMASI PESANAN (Screen konfirmasi Remake - Figma)
// Muncul setelah user menekan "Pesan Sekarang" di Halaman Pesan Laundry
// Full Front-End Only, Kode Sederhana & Ramah Pemula
// ====================================================================
class HalamanKonfirmasiPesanan extends StatelessWidget {
  // Data pesanan yang dikirim dari Halaman Pesan Laundry
  final String orderId;
  final String estimasiDijemput;

  // Aksi tombol "Lacak Pesanan" (diisi nanti saat halaman tracking map jadi)
  final VoidCallback? onLacakPesanan;

  const HalamanKonfirmasiPesanan({
    super.key,
    this.orderId = '#ZF-1202',
    this.estimasiDijemput = '14:00 WIB',
    this.onLacakPesanan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // 1. Ikon Centang Biru dengan Glow
              ikonBerhasil(),
              const SizedBox(height: 36),

              // 2. Judul & Deskripsi
              Text(
                'Pesanan Diterima!',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF191C1D),
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Terimakasih telah memesan! Cucian\nAnda sedang kami proses.',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF424654),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // 3. Kartu Info Pesanan (Order ID & Estimasi Dijemput)
              kartuInfoPesanan(),

              const Spacer(flex: 1),

              // 4. Tombol Lacak Pesanan
              tombolLacakPesanan(context),
              const SizedBox(height: 20),

              // 5. Tombol Kembali ke Beranda
              GestureDetector(
                onTap: () {
                  // Kembali ke halaman paling awal (Beranda)
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Kembali ke Beranda',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0040A1),
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // 1. WIDGET: IKON CENTANG (Lingkaran biru + glow, animasi muncul)
  // ==========================================================
  Widget ikonBerhasil() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.6, end: 1.0),
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutBack,
      builder: (context, nilai, child) {
        return Transform.scale(scale: nilai, child: child);
      },
      child: Container(
        width: 160,
        height: 160,
        alignment: Alignment.center,
        // Glow biru lembut di belakang lingkaran
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              const Color(0xFF0056D2).withValues(alpha: 0.22),
              const Color(0xFF0056D2).withValues(alpha: 0.0),
            ],
          ),
        ),
        child: Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0056D2),
                Color(0xFF0040A1),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0040A1).withValues(alpha: 0.35),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.check_rounded,
            color: Colors.white,
            size: 48,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // 3. WIDGET: KARTU INFO PESANAN
  // ==========================================================
  Widget kartuInfoPesanan() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Baris Order ID
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order ID',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF424654),
                ),
              ),
              Text(
                orderId,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF191C1D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Baris Estimasi Dijemput (warna oranye + ikon jam)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Estimasi dijemput',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF424654),
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.access_time_filled_rounded,
                    color: Color(0xFFF29900),
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    estimasiDijemput,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFF29900),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // 4. WIDGET: TOMBOL LACAK PESANAN
  // ==========================================================
  Widget tombolLacakPesanan(BuildContext context) {
    return TombolLacakPesanan(onTap: onLacakPesanan);
  }
}

// Tombol dengan animasi tekan (mengecil saat ditekan).
// Kalau onTap kosong (halaman tracking belum ada), tombol tetap reaktif
// tapi tidak melakukan apa-apa.
class TombolLacakPesanan extends StatefulWidget {
  final VoidCallback? onTap;

  const TombolLacakPesanan({super.key, this.onTap});

  @override
  State<TombolLacakPesanan> createState() => _TombolLacakPesananState();
}

class _TombolLacakPesananState extends State<TombolLacakPesanan> {
  double skala = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => skala = 0.96),
      onTapUp: (_) {
        setState(() => skala = 1.0);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => skala = 1.0),
      child: AnimatedScale(
        scale: skala,
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
                'Lacak Pesanan',
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
    );
  }
}
