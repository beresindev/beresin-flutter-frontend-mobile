import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_beresin/common/theme.dart';

class DetailUnggahProdukPage extends StatefulWidget {
  const DetailUnggahProdukPage({super.key});

  @override
  State<DetailUnggahProdukPage> createState() => _DetailUnggahProdukPageState();
}

class _DetailUnggahProdukPageState extends State<DetailUnggahProdukPage> {
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  String? _kategori;
  RangeValues _hargaRange = const RangeValues(0, 100);

  late ImagePicker _imagePicker;
  String? selectedImagePath;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  Future<void> _getImageFromGallery() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImagePath = pickedImage.path;
      setState(() {});
    }
  }

  final List<String> _kategories = [
    'Elektronik',
    'Pakaian',
    'Makanan',
    'Buku',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          decoration: BoxDecoration(
            color: alternativeBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 7.0,
                spreadRadius: 1.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: primaryColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.keyboard_backspace,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  'Unggah',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600, // semibold
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.more_vert_outlined,
                  size: 24.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama barang / jasa',
                      style: TextStyle(
                        fontSize: 14,
                        color: alternativeBlackTextColor,
                        fontWeight: medium,
                      ),
                    ),
                    TextField(
                      controller: _namaBarangController,
                      decoration: InputDecoration(
                        hintText: 'Masukan nama jasa anda',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          color: secondaryTextColor,
                          fontWeight: regular,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: secondaryTextColor,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: alternativeBlackTextColor,
                        fontWeight: regular,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Kategori',
                      style: TextStyle(
                        fontSize: 14,
                        color: alternativeBlackTextColor,
                        fontWeight: medium,
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      value: _kategori,
                      items: _kategories.map((String kategori) {
                        return DropdownMenuItem<String>(
                          value: kategori,
                          child: Text(
                            kategori,
                            style: TextStyle(
                              fontSize: 14,
                              color: alternativeBlackTextColor,
                              fontWeight: regular,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _kategori = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Pilih Kategori',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          color: secondaryTextColor,
                          fontWeight: regular,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: secondaryTextColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                        'Range Harga: ${_hargaRange.start.toInt()} - ${_hargaRange.end.toInt()}'),
                    RangeSlider(
                      values: _hargaRange,
                      min: 0,
                      max: 1000,
                      divisions: 100,
                      labels: RangeLabels(
                        _hargaRange.start.toString(),
                        _hargaRange.end.toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _hargaRange = values;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Unggah 2 Foto',
                      style: TextStyle(
                        fontSize: 14,
                        color: alternativeBlackTextColor,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: _getImageFromGallery,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primaryColor,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Unggah',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: primaryColor,
                                fontWeight: semibold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            SvgPicture.asset(
                              'assets/svg/upload.svg',
                              height: 24,
                              width: 24,
                              fit: BoxFit.none,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Format gambar png atau jpg',
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (selectedImagePath != null)
                      Image.file(
                        File(selectedImagePath!),
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    const SizedBox(height: 16),
                    Text(
                      'Deskripsi',
                      style: TextStyle(
                        fontSize: 14,
                        color: alternativeBlackTextColor,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _deskripsiController,
                      maxLength: 300,
                      minLines: 5,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Deskripsi',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          color: secondaryTextColor,
                          fontWeight: regular,
                        ),
                        alignLabelWithHint: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          borderSide: BorderSide(
                            color: alternativeBlackColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 2,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(12, 16, 12, 8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  top: 15, bottom: 25, right: 20, left: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Chat Lewat WA?',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: primaryTextColor,
                        fontWeight: semibold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.whatshot,
                      color: primaryTextColor,
                      size: 24.0,
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
}
