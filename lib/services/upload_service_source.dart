import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_beresin/constants/api_constants.dart';
import 'package:mobile_beresin/models/service_model.dart';

class UploadService {
  Future<bool> uploadData({
    required String token,
    required String namaBarang,
    required String deskripsi,
    required String kategori,
    required List<String> pathImages, // daftar path gambar
  }) async {
    final uri =
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.postUploadService}');

    try {
      var headers = {
        "Content-Type": "multipart/form-data",
        'Authorization': 'Bearer $token',
      };

      List<http.MultipartFile> imageFiles = [];

      for (String image in pathImages) {
        var imageBytes = await http.MultipartFile.fromPath(
          'images',
          image,
        );
        log('image path: $image');
        imageFiles.add(imageBytes);
      }

      final request = http.MultipartRequest("POST", uri);
      request.headers.addAll(headers);
      request.fields['name_of_service'] = namaBarang;
      request.fields['description'] = deskripsi;
      request.fields['category_id'] = '1';

      // request.files.addAll(imageFiles);

      log(request.fields.toString());
      log(request.files.toString());

      var response = await request.send();

      if (response.statusCode == 201) {
        var result = await http.Response.fromStream(response);
        log('success: ${result.body}');
        return true;
      } else {
        // Menangkap status code yang tidak berhasil
        final errorResponse = await response.stream.bytesToString();
        throw Exception(
          'Upload failed with status ${response.statusCode}: $errorResponse',
        );
      }
    } catch (e) {
      // Menangkap exception jika ada kesalahan jaringan atau lainnya
      throw Exception('Upload error: $e');
    }
  }

  Future<ServiceModel> uploadDataJson({
    required String token,
    required String namaBarang,
    required String deskripsi,
    required String kategori,
    required List<String> pathImages, // daftar path gambar
  }) async {
    final uri =
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.postUploadService}');

    try {
      // Menyusun header untuk JSON
      var headers = {
        "Content-Type": "application/json", // Menggunakan content-type JSON
        'Authorization': 'Bearer $token',
      };

      // Membaca file gambar dan mengonversinya ke base64
      List<String> base64Images = [];
      for (String imagePath in pathImages) {
        File imageFile = File(imagePath);
        if (await imageFile.exists()) {
          List<int> imageBytes = await imageFile.readAsBytes();
          String base64Image = base64Encode(imageBytes);
          base64Images.add("data:image/png;base64,$base64Image");
          log('Image converted to base64: $base64Image');
        } else {
          throw Exception('File not found: $imagePath');
        }
      }

      // Menyiapkan data untuk dikirimkan dalam body JSON
      var body = jsonEncode({
        "name_of_service": namaBarang,
        "description": deskripsi,
        "category_id": kategori,
        "images": base64Images, // Mengirim gambar sebagai array base64
      });

      // Mengirimkan POST request dengan body JSON
      var response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 201) {
        log('Success: ${response.body}');
        var data = jsonDecode(response.body)['service'];
        ServiceModel result = ServiceModel.fromJson(data);
        return result;
      } else {
        // Menangkap status code yang tidak berhasil
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      // Menangkap exception jika ada kesalahan jaringan atau lainnya
      rethrow;
    }
  }
}
