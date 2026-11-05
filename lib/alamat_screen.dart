import 'package:flutter/material.dart';

class AddressColors {
  AddressColors._();
  static const primary = Color(0xFF0B3C9D);
  static const primaryLight = Color(0xFF2F63D6);
  static const bg = Color(0xFFF4F6FA);
  static const iconBg = Color(0xFFE6EDFB);
  static const textGrey = Color(0xFF6B7280);
}

class AddressModel {
  final String id, label, fullAddress;
  final String? note;
  final bool isPrimary;
  final String iconType;

  const AddressModel({
    required this.id,
    required this.label,
    required this.fullAddress,
    this.note,
    this.isPrimary = false,
    this.iconType = 'pin',
  });
}

const _alamatDummy =
    'Telkom University Landmark Tower (TULT), Jl. Telekomunikasi No. 1 '
    'Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40267';

const _bold14 = TextStyle(fontWeight: FontWeight.w700, fontSize: 14);
const _body12 = TextStyle(fontSize: 12, height: 1.4);
const _grey12 = TextStyle(fontSize: 12, color: AddressColors.textGrey);

Widget _circle(
  double size,
  Color color, {
  Widget? child,
  Border? border,
  List<BoxShadow>? shadow,
}) => Container(
  width: size,
  height: size,
  alignment: Alignment.center,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: color,
    border: border,
    boxShadow: shadow,
  ),
  child: child,
);

InputDecoration _searchDecoration(String hint, Color fill, {Widget? suffix}) =>
    InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 12),
      prefixIcon: const Icon(Icons.search, size: 20),
      suffixIcon: suffix,
      filled: true,
      fillColor: fill,
      contentPadding: EdgeInsets.zero,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );

class _IconBox extends StatelessWidget {
  final IconData icon;
  final double size;
  const _IconBox(this.icon, {this.size = 20});

  @override
  Widget build(BuildContext context) => Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: AddressColors.iconBg,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Icon(icon, color: AddressColors.primary, size: size),
  );
}

class _AddressRow extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Widget title;
  final String address;
  final String? note;
  const _AddressRow({
    required this.icon,
    this.iconSize = 20,
    required this.title,
    required this.address,
    this.note,
  });

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _IconBox(icon, size: iconSize),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            const SizedBox(height: 4),
            Text(address, style: _body12),
            if (note != null && note!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                'Catatan: $note',
                style: const TextStyle(
                  fontSize: 11,
                  color: AddressColors.textGrey,
                ),
              ),
            ],
          ],
        ),
      ),
    ],
  );
}

class GradientButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  const GradientButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(16),
    clipBehavior: Clip.antiAlias,
    child: Ink(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AddressColors.primaryLight, AddressColors.primary],
        ),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: Colors.white, size: 18),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class AddressCard extends StatelessWidget {
  final AddressModel data;
  final bool selected;
  final VoidCallback? onTap;
  const AddressCard({
    super.key,
    required this.data,
    required this.selected,
    this.onTap,
  });

  static const _icons = {
    'home': Icons.home_rounded,
    'campus': Icons.school_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AddressColors.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _AddressRow(
                icon: _icons[data.iconType] ?? Icons.location_on_rounded,
                address: data.fullAddress,
                note: data.note,
                title: Row(
                  children: [
                    Text(data.label, style: _bold14),
                    if (data.isPrimary)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AddressColors.iconBg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Utama',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AddressColors.primary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (selected)
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.check_circle,
                  color: AddressColors.primary,
                  size: 22,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MapLayout extends StatelessWidget {
  final String title, searchHint;
  final List<Widget> sheetChildren;
  const MapLayout({
    super.key,
    required this.title,
    required this.searchHint,
    required this.sheetChildren,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/peta_dummy.png',
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const ColoredBox(
                color: Color(0xFFE3E8EF),
                child: Center(
                  child: Icon(Icons.map_outlined, size: 64, color: Colors.grey),
                ),
              ),
            ),
          ),
          const Positioned.fill(
            child: Align(alignment: Alignment(0, -0.2), child: _MapPin()),
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  color: const Color(0xE6FFFFFF),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AddressColors.primary,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(12),
                    child: TextField(
                      decoration: _searchDecoration(searchHint, Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 12),
                  child: _circle(
                    44,
                    Colors.white,
                    shadow: const [
                      BoxShadow(color: Color(0x33000000), blurRadius: 6),
                    ],
                    child: const Icon(
                      Icons.my_location,
                      color: AddressColors.primary,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    16,
                    10,
                    16,
                    16 + MediaQuery.of(context).viewInsets.bottom,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(color: Color(0x1A000000), blurRadius: 16),
                    ],
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        ...sheetChildren,
                      ],
                    ),
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

class _MapPin extends StatelessWidget {
  const _MapPin();

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _circle(
        56,
        const Color(0x260B3C9D),
        child: _circle(
          40,
          AddressColors.primary,
          border: Border.all(color: Colors.white, width: 3),
          child: const Icon(Icons.location_on, color: Colors.white, size: 20),
        ),
      ),
      const SizedBox(height: 4),
      _circle(8, AddressColors.primary),
    ],
  );
}

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  final List<AddressModel> _addresses = [
    const AddressModel(
      id: '1',
      label: 'Kos',
      isPrimary: true,
      iconType: 'home',
      fullAddress:
          'Kosan Harapan Indah, Sukapura, Kab. Bandung, Jawa Barat 11530',
      note: 'Pagar warna biru',
    ),
    const AddressModel(
      id: '2',
      label: 'Kampus',
      iconType: 'campus',
      fullAddress: _alamatDummy,
      note: 'Simpan di satpam',
    ),
  ];
  int _selectedIndex = 0;

  Future<void> _bukaPeta() async {
    final hasil = await Navigator.push<AddressModel>(
      context,
      MaterialPageRoute(
        builder: (_) => const PilihTempatScreen(alamat: _alamatDummy),
      ),
    );
    if (hasil != null && mounted) {
      setState(() {
        _addresses.add(hasil);
        _selectedIndex = _addresses.length - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AddressColors.bg,
      appBar: AppBar(
        backgroundColor: AddressColors.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AddressColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Atur Alamat',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          TextField(
            decoration: _searchDecoration(
              'Cari Alamat',
              const Color(0xFFE6E9EF),
              suffix: const Icon(Icons.mic, size: 20),
            ),
          ),
          const SizedBox(height: 12),
          GradientButton(
            text: 'Gunakan Lokasi Saat Ini',
            icon: Icons.my_location,
            onPressed: _bukaPeta,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _bukaPeta,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.map_rounded, color: Colors.orange, size: 22),
                  Expanded(
                    child: Text(
                      'Pilih dari Peta',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(Icons.chevron_right, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Alamat Tersimpan',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              GestureDetector(
                onTap: _bukaPeta,
                child: const Text(
                  'Tambah Baru',
                  style: TextStyle(
                    color: AddressColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (int i = 0; i < _addresses.length; i++)
            AddressCard(
              data: _addresses[i],
              selected: i == _selectedIndex,
              onTap: () => setState(() => _selectedIndex = i),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 16)],
        ),
        child: SafeArea(
          top: false,
          child: GradientButton(
            text: 'Pilih Alamat',
            onPressed: () => Navigator.pop(context, _addresses[_selectedIndex]),
          ),
        ),
      ),
    );
  }
}

class PilihTempatScreen extends StatelessWidget {
  final String alamat;
  const PilihTempatScreen({super.key, required this.alamat});

  Future<void> _konfirmasi(BuildContext context) async {
    final hasil = await Navigator.push<AddressModel>(
      context,
      MaterialPageRoute(builder: (_) => SimpanAlamatScreen(alamat: alamat)),
    );
    if (hasil != null && context.mounted) Navigator.pop(context, hasil);
  }

  @override
  Widget build(BuildContext context) {
    return MapLayout(
      title: 'Pilih Tempat',
      searchHint: 'Cari lokasi penjemputan...',
      sheetChildren: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Pilih Alamat', style: _grey12),
            Text(
              'Edit',
              style: TextStyle(fontSize: 12, color: AddressColors.primary),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _AddressRow(
          icon: Icons.home_rounded,
          title: const Text('Kos', style: _bold14),
          address: alamat,
        ),
        const SizedBox(height: 16),
        GradientButton(
          text: 'Konfirmasi Lokasi',
          onPressed: () => _konfirmasi(context),
        ),
      ],
    );
  }
}

class SimpanAlamatScreen extends StatefulWidget {
  final String alamat;
  const SimpanAlamatScreen({super.key, required this.alamat});

  @override
  State<SimpanAlamatScreen> createState() => _SimpanAlamatScreenState();
}

class _SimpanAlamatScreenState extends State<SimpanAlamatScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      AddressModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        label: _namaController.text.trim(),
        fullAddress: widget.alamat,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MapLayout(
      title: 'Simpan Alamat Baru',
      searchHint: 'Cari lokasi...',
      sheetChildren: [
        const Text('Lengkapi Alamat', style: _grey12),
        const SizedBox(height: 12),
        _AddressRow(
          icon: Icons.circle,
          iconSize: 16,
          address: widget.alamat,
          title: Form(
            key: _formKey,
            child: TextFormField(
              controller: _namaController,
              style: _bold14,
              decoration: const InputDecoration(
                hintText: 'Isi Nama Custom',
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Nama alamat wajib diisi'
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 16),
        GradientButton(text: 'Simpan Lokasi', onPressed: _simpan),
      ],
    );
  }
}
