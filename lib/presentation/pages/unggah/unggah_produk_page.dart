import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/presentation/pages/unggah/draft_produk_page.dart';
import 'package:mobile_beresin/presentation/widgets/minmax_price_model.dart';
import 'package:mobile_beresin/providers/service_provider.dart';
import 'package:provider/provider.dart';

class UnggahProdukPage extends StatefulWidget {
  const UnggahProdukPage({super.key});

  @override
  State<UnggahProdukPage> createState() => _UnggahProdukPageState();
}

class _UnggahProdukPageState extends State<UnggahProdukPage> {
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _rangeHargaMinController =
      TextEditingController();
  final TextEditingController _rangeHargaMaxController =
      TextEditingController();
  int parsePrice(String value) {
    // Hapus semua karakter non-digit
    String cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    return int.parse(cleanedValue);
  }

  // String? _kategori;
  // RangeValues _hargaRange = const RangeValues(0, 100);
  String? _kategoriId;

  late ImagePicker _imagePicker;
  List<String> selectedImagesPath = [];

  Future<void> onUploadData() async {
    log('kepetek');
    await context
        .read<ServiceProvider>()
        .uploadData(
          imagePaths: selectedImagesPath,
          namaBarang: _namaBarangController.text,
          deskripsi: _deskripsiController.text,
          kategori: _kategoriId ?? '',
          minPrice: parsePrice(_rangeHargaMinController.text),
          maxPrice: parsePrice(_rangeHargaMaxController.text),
        )
        .then(
      (value) {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DraftProdukPage(),
            ));
      },
    ).onError(
      (error, stackTrace) {
        Fluttertoast.showToast(
          msg: error.toString(),
          backgroundColor: debugColor,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  Future<void> _getImageFromGallery() async {
    if (selectedImagesPath.length < 2) {
      // hanya akan menambah gambar jika jumlahnya kurang dari 2
      final pickedImage =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        // Mendapatkan ukuran file gambar
        File imageFile = File(pickedImage.path);
        int imageSizeInBytes = await imageFile.length();

        // Mengonversi ukuran ke MB (1 MB = 1024 * 1024 bytes)
        double imageSizeInMB = imageSizeInBytes / (1024 * 1024);

        // Memeriksa apakah ukuran gambar lebih kecil dari 5 MB
        if (imageSizeInMB <= 5) {
          selectedImagesPath = [...selectedImagesPath, pickedImage.path];
          setState(() {});
        } else {
          // Menampilkan toast jika gambar terlalu besar
          Fluttertoast.showToast(
            msg: "Ukuran gambar terlalu besar. Maksimal 5 MB.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    } else {
      // Menampilkan toast jika user mencoba memilih lebih dari 2 gambar
      Fluttertoast.showToast(
        msg: "Anda hanya bisa memilih maksimal 2 gambar",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ServiceProvider>();
    return Scaffold(
      backgroundColor: backgroundColor,
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
                    Icons.arrow_back_sharp,
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
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama Barang / Jasa',
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
                            value: _kategoriId,
                            items: context
                                .read<ServiceProvider>()
                                .categories
                                .map((kategori) {
                              return DropdownMenuItem<String>(
                                value: kategori.id
                                    .toString(), // Use id as the value
                                child: Text(
                                  kategori
                                      .nameOfCategory, // Display the category name
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
                                _kategoriId =
                                    value; // Convert string id back to int
                              });
                              log(value ?? 'kosong');
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
                            'Range Harga',
                            style: TextStyle(
                              fontSize: 14,
                              color: alternativeBlackTextColor,
                              fontWeight: medium,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  labelText: '',
                                  hintText: 'Min',
                                  keyboardType: TextInputType.number,
                                  controller: _rangeHargaMinController,
                                  isCurrency: true,
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Center(
                                  child: Text(
                                    'To',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: alternativeBlackTextColor,
                                      fontWeight: medium,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: CustomTextField(
                                  labelText: '',
                                  hintText: 'Min',
                                  keyboardType: TextInputType.number,
                                  controller: _rangeHargaMaxController,
                                  isCurrency: true,
                                ),
                              ),
                            ],
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
                          if (selectedImagesPath.isNotEmpty)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...selectedImagesPath.map(
                                    (image) {
                                      int index = selectedImagesPath.indexOf(
                                          image); // Mendapatkan index gambar
                                      return Stack(
                                        children: [
                                          Image.file(
                                            File(image),
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedImagesPath.removeAt(
                                                      index); // Menghapus gambar berdasarkan index
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                ],
                              ),
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
                              hintText: 'Tulis deskripsi',
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
                          const SizedBox(height: 120),
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
                    color: backgroundColor,
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 20, right: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              width: 1,
                              color: primaryColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Batal',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: primaryColor,
                                fontWeight: semibold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: onUploadData,
                          child: Container(
                            width: 160,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Upload',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: primaryTextColor,
                                  fontWeight: semibold,
                                ),
                              ),
                            ),
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
}
