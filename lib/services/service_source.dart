import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:mobile_beresin/constants/api_constants.dart';
import 'package:mobile_beresin/models/category_model.dart';
import 'package:mobile_beresin/models/service_model.dart';
import 'package:http/http.dart' as http;

class ServiceSource {
  Future<List<ServiceModel>> getAllServices({
    required String token,
  }) async {
    var url = '${ApiConstants.baseUrl}${ApiConstants.getAllService}';
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['services'];
      List<ServiceModel> savings =
          data.map((item) => ServiceModel.fromJson(item)).toList();
      log('succes service');
      return savings;
    } else {
      throw jsonDecode(response.body)['message'];
    }
  }

  // Future<List<CategoryModel>> getCategories({
  //   required String token,
  // }) async {
  //   var url = '${ApiConstants.baseUrl}${ApiConstants.getCategories}';
  //   var headers = {
  //     'Authorization': 'Bearer $token',
  //   };
  //   final response = await http.get(
  //     Uri.parse(url),
  //     headers: headers,
  //   );

  //   print(response.body);

  //   if (response.statusCode == 200) {
  //     List data = jsonDecode(response.body)['categories'];
  //     List<CategoryModel> result =
  //         data.map((item) => CategoryModel.fromJson(item)).toList();
  //     log('succes categories');
  //     return result;
  //   } else {
  //     throw jsonDecode(response.body)['messages'];
  //   }
  // }

  Future<List<ServiceModel>> getDraftService({
    required String token,
  }) async {
    var url = '${ApiConstants.baseUrl}${ApiConstants.getDraftServices}';
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['services'];
      List<ServiceModel> savings =
          data.map((item) => ServiceModel.fromJson(item)).toList();
      log('succes service');
      return savings;
    } else {
      throw jsonDecode(response.body)['message'];
    }
  }

  Future<bool> uploadDataJson({
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
          // Membaca file dan mengonversinya menjadi base64
          List<int> imageBytes = await imageFile.readAsBytes();
          String base64Image = base64Encode(imageBytes);
          base64Images.add(base64Image);
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
        return true;
      } else {
        // Menangkap status code yang tidak berhasil
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      // Menangkap exception jika ada kesalahan jaringan atau lainnya
      rethrow;
    }
  }

  Future<bool> deleteService({
    required String token,
    required int serviceId,
  }) async {
    var url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getDraftServices}/$serviceId');
    var headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.delete(
      url,
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body)['data'];

      return true;
    } else {
      throw jsonDecode(response.body)['message'];
    }
  }
}
