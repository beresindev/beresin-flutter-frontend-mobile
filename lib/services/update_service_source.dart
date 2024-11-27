// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:http/http.dart' as http;
// import 'package:mobile_beresin/constants/api_constants.dart';
// import 'package:mobile_beresin/models/service_model.dart';

// class UpdateServiceSource {
//   // Future<bool> updateData({
//   //   String? token,
//   //   String? namaBarang,
//   //   String? deskripsi,
//   //   String? kategori,
//   //   int? minPrice,
//   //   int? maxPrice,
//   //   List<String>? pathImages, // daftar path gambar
//   //   required int id,
//   // }) async {
//   //   final uri = Uri.parse(
//   //       '${ApiConstants.baseUrl}${ApiConstants.putUploadService}/$id');

//   //   try {
//   //     var headers = {
//   //       "Content-Type": "multipart/form-data",
//   //       'Authorization': 'Bearer $token',
//   //     };

//   //     List<http.MultipartFile> imageFiles = [];

//   //     for (String image in pathImages!) {
//   //       var imageBytes = await http.MultipartFile.fromPath(
//   //         'images',
//   //         image,
//   //       );
//   //       log('image path: $image');
//   //       imageFiles.add(imageBytes);
//   //     }

//   //     final request = http.MultipartRequest("PUT", uri);
//   //     request.headers.addAll(headers);
//   //     request.fields['name_of_service'] = namaBarang!;
//   //     request.fields['description'] = deskripsi!;
//   //     request.fields['category_id'] = '1';
//   //     request.fields['min_price'] = minPrice.toString();
//   //     request.fields['max_price'] = maxPrice.toString();

//   //     // request.files.addAll(imageFiles);

//   //     log(request.fields.toString());
//   //     log(request.files.toString());

//   //     var response = await request.send();

//   //     if (response.statusCode == 201) {
//   //       var result = await http.Response.fromStream(response);
//   //       log('success: ${result.body}');
//   //       return true;
//   //     } else {
//   //       // Menangkap status code yang tidak berhasil
//   //       final errorResponse = await response.stream.bytesToString();
//   //       throw Exception(
//   //         'Upload failed with status ${response.statusCode}: $errorResponse',
//   //       );
//   //     }
//   //   } catch (e) {
//   //     // Menangkap exception jika ada kesalahan jaringan atau lainnya
//   //     throw Exception('Upload error: $e');
//   //   }
//   // }

//   Future<ServiceModel> updateDataJson({
//     String? token,
//     String? namaBarang,
//     String? deskripsi,
//     String? kategori,
//     int? minPrice,
//     int? maxPrice,
//     List<String>? pathImages, // daftar path gambar
//     required int? id,
//   }) async {
//     final uri = Uri.parse(
//         '${ApiConstants.baseUrl}${ApiConstants.putUploadService}/$id');

//     try {
//       // Menyusun header untuk multipart
//       var headers = {
//         "Content-Type":
//             "multipart/form-data", // Menggunakan multipart/form-data
//         'Authorization': 'Bearer $token',
//       };

//       // Membaca file gambar dan mengonversinya menjadi MultipartFile
//       List<http.MultipartFile> imageFiles = [];
//       List<String> imageUrls = [];

//       // if (pathImages != null && pathImages.isNotEmpty) {
//       //   for (String image in pathImages) {
//       //     if (image.startsWith("http")) {
//       //       // Handle image URL directly if it's a URL (fetch it from server if needed)
//       //       // For now, just log for debugging
//       //       log('URL image: $image');
//       //     } else {
//       //       // Jika gambar adalah file lokal
//       //       var imageBytes = await http.MultipartFile.fromPath(
//       //         'images',
//       //         image,
//       //       );
//       //       log('image path: $image');
//       //       imageFiles.add(imageBytes);
//       //     }
//       //   }
//       // }

//       if (pathImages != null && pathImages.isNotEmpty) {
//         for (String image in pathImages) {
//           if (image.startsWith("http")) {
//             // Ambil path gambar dari URL, menghapus URL server bagian awal
//             var uriImage = Uri.parse(image);
//             String pathImage = uriImage.path; // Ambil hanya path
//             imageUrls.add(pathImage); // Simpan path saja

//             // Menambahkan path URL sebagai MultipartFile ke dalam imageFiles
//             var imageFileFromUrl = await http.MultipartFile.fromPath(
//               'images',
//               pathImage,
//             );
//             imageFiles.add(imageFileFromUrl);

//             log('Image path from URL: $pathImage');
//           } else {
//             // Jika gambar adalah file lokal
//             var imageBytes = await http.MultipartFile.fromPath(
//               'images',
//               image,
//             );
//             log('Local image path: $image');
//             imageFiles.add(imageBytes);
//           }
//         }
//       }

//       // Menyiapkan request multipart
//       var request = http.MultipartRequest('PUT', uri);
//       request.headers.addAll(headers);
//       request.fields['name_of_service'] = namaBarang!;
//       request.fields['description'] = deskripsi!;
//       request.fields['category_id'] = kategori!;
//       request.fields['min_price'] = minPrice.toString();
//       request.fields['max_price'] = maxPrice.toString();

//       // Menambahkan file gambar ke request multipart
//       request.files.addAll(imageFiles);

//       log('Request fields: ${request.fields}');
//       log('Request files: ${request.files}');

//       // Mengirimkan request multipart
//       var response = await request.send();

//       if (response.statusCode == 200) {
//         var result = await http.Response.fromStream(response);
//         log('Success: ${result.body}');
//         var data = jsonDecode(result.body)['service'];
//         ServiceModel service = ServiceModel.fromJson(data);
//         return service;
//       } else {
//         // Menangkap status code yang tidak berhasil
//         final errorResponse = await response.stream.bytesToString();
//         throw Exception(
//           'Upload failed with status ${response.statusCode}: $errorResponse',
//         );
//       }
//     } catch (e) {
//       // Menangkap exception jika ada kesalahan jaringan atau lainnya
//       log(e.toString());
//       rethrow;
//     }
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_beresin/constants/api_constants.dart';
import 'package:mobile_beresin/models/service_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class UpdateServiceSource {
  Future<File> downloadImage(String imageUrl) async {
    try {
      // Unduh file dari URL
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // Ambil direktori sementara aplikasi
        final directory = await getTemporaryDirectory();
        final filePath = path.join(directory.path, path.basename(imageUrl));

        // Simpan file ke direktori lokal
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        return file;
      } else {
        throw Exception('Failed to load image from URL');
      }
    } catch (e) {
      throw Exception('Error downloading image: $e');
    }
  }

  Future<ServiceModel> updateDataJson({
    String? token,
    String? namaBarang,
    String? deskripsi,
    String? kategori,
    int? minPrice,
    int? maxPrice,
    List<String>? pathImages, // daftar path gambar
    required int? id,
  }) async {
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.putUploadService}/$id');

    try {
      var headers = {
        "Content-Type": "multipart/form-data",
        'Authorization': 'Bearer $token',
      };

      List<http.MultipartFile> imageFiles = [];

      if (pathImages != null && pathImages.isNotEmpty) {
        for (String image in pathImages) {
          if (image.startsWith("http")) {
            // Unduh gambar dari URL
            final file = await downloadImage(image);

            // Tambahkan file yang sudah diunduh ke request multipart
            var imageFile =
                await http.MultipartFile.fromPath('images', file.path);
            imageFiles.add(imageFile);

            log('Downloaded and added image: ${file.path}');
          } else {
            // Jika gambar adalah file lokal
            var imageBytes = await http.MultipartFile.fromPath('images', image);
            imageFiles.add(imageBytes);
          }
        }
      }

      var request = http.MultipartRequest('PUT', uri);
      request.headers.addAll(headers);
      request.fields['name_of_service'] = namaBarang!;
      request.fields['description'] = deskripsi!;
      request.fields['category_id'] = kategori!;
      request.fields['min_price'] = minPrice.toString();
      request.fields['max_price'] = maxPrice.toString();

      // Menambahkan file gambar ke request multipart
      request.files.addAll(imageFiles);

      log('Request fields: ${request.fields}');
      log('Request files: ${request.files}');

      var response = await request.send();

      if (response.statusCode == 200) {
        var result = await http.Response.fromStream(response);
        log('Success: ${result.body}');
        var data = jsonDecode(result.body)['service'];
        ServiceModel service = ServiceModel.fromJson(data);
        return service;
      } else {
        final errorResponse = await response.stream.bytesToString();
        throw Exception(
          'Upload failed with status ${response.statusCode}: $errorResponse',
        );
      }
    } catch (e) {
      log('Error: $e');
      rethrow;
    }
  }
}
