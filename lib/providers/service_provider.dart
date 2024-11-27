import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_beresin/common/token_manager.dart';
import 'package:mobile_beresin/models/category_model.dart';
import 'package:mobile_beresin/models/service_model.dart';
import 'package:mobile_beresin/services/service_source.dart';
import 'package:mobile_beresin/services/update_service_source.dart';
import 'package:mobile_beresin/services/upload_service_source.dart';

class ServiceProvider with ChangeNotifier {
  final tokenManager = TokenManager();

  List<ServiceModel> _draftServices = [];
  List<ServiceModel> get draftServices => _draftServices;

  List<ServiceModel> _services = [];
  List<ServiceModel> get services => _services;

  String _searchKeyword = '';
  String get searchKeyword => _searchKeyword;

  late int _minPrice;
  int get minPrice => _minPrice;

  late int _maxPrice;
  int get maxPrice => _maxPrice;

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  bool isLoading = false;

  Future<bool> getAllServices() async {
    isLoading = true;
    notifyListeners();
    try {
      log("Masuk provider");
      List<ServiceModel> result = await ServiceSource().getAllServices(
        token: (await tokenManager.getToken())!,
      );

      result.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      _services = result;
      isLoading = false;
      notifyListeners();
      log("INI ISI DARI GET SAVINGS");
      return true;
    } on SocketException {
      _services = [];
      isLoading = false;
      notifyListeners();
      // rethrow;
      throw "No Internet Connection";
    } catch (error) {
      log('qqqqqq $error');
      _services = [];
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Future<bool> getDraftServices() async {
  //   isLoading = true;
  //   notifyListeners();
  //   try {
  //     log("masuk get draft service");
  //     List<ServiceModel> result = await ServiceSource().getDraftService(
  //       token: (await tokenManager.getToken())!,
  //     );

  //     result.sort((a, b) => b.createdAt.compareTo(a.createdAt));

  //     _draftServices = result;
  //     isLoading = false;
  //     notifyListeners();
  //     log("draft service get");
  //     return true;
  //   } on SocketException {
  //     _draftServices = [];
  //     isLoading = false;
  //     notifyListeners();
  //     // rethrow;
  //     throw "No Internet Connection";
  //   } catch (error) {
  //     log('draft service error: $error');
  //     _draftServices = [];
  //     isLoading = false;
  //     notifyListeners();
  //     return false;
  //   }
  // }

  Future<bool> getDraftServices({bool forceRefresh = false}) async {
    isLoading = true;
    notifyListeners();

    try {
      log("masuk get draft service");

      // Jika forceRefresh true, reset data sebelumnya sebelum mengambil data baru
      if (forceRefresh) {
        _draftServices = [];
        notifyListeners();
      }

      // Ambil data terbaru dari server
      List<ServiceModel> result = await ServiceSource().getDraftService(
        token: (await tokenManager.getToken())!,
      );

      // Mengurutkan data berdasarkan createdAt
      result.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      _draftServices = result;
      isLoading = false;
      notifyListeners();
      log("draft service get");
      return true;
    } on SocketException {
      _draftServices = [];
      isLoading = false;
      notifyListeners();
      throw "No Internet Connection";
    } catch (error) {
      log('draft service error: $error');
      _draftServices = [];
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  set searchKeyword(String value) {
    _searchKeyword = value;
    notifyListeners();
  }

  set minPrice(int value) {
    _minPrice = value;
    notifyListeners();
  }

  set maxPrice(int value) {
    _maxPrice = value;
    notifyListeners();
  }

  List<ServiceModel> get filteredServices {
    if (searchKeyword.isEmpty) {
      return _services;
    } else {
      return _services.where((service) {
        return service.nameOfService
            .toLowerCase()
            .contains(searchKeyword.toLowerCase());
      }).toList();
    }
  }

  Future<bool> deleteService({
    required int serviceId,
  }) async {
    try {
      await ServiceSource().deleteService(
        serviceId: serviceId,
        token: (await tokenManager.getToken())!,
      );

      _draftServices.removeWhere((service) => service.id == serviceId);

      notifyListeners();
      return true;
    } on SocketException {
      // print("tes");

      throw 'Tidak ada koneksi internet';
    } catch (error) {
      // print(error);
      rethrow;
    }
  }

  Future<bool> getCategories() async {
    isLoading = true;
    notifyListeners();
    try {
      log("Masuk provider");
      List<CategoryModel> result = CategoryModel.getDummyCategories();
      _categories = result;
      isLoading = false;
      notifyListeners();
      log("INI ISI DARI GET SAVINGS");
      return true;
    } on SocketException {
      _categories = [];
      isLoading = false;
      notifyListeners();
      // rethrow;
      throw "No Internet Connection";
    } catch (error) {
      log('qqqqqq $error');
      _categories = [];
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> uploadData({
    required String namaBarang,
    required String deskripsi,
    required String kategori,
    required int minPrice,
    required int maxPrice,
    required List<String> imagePaths,
  }) async {
    // selectedImagePaths = imagePaths;
    log('masuk upload');
    isLoading = true;
    notifyListeners();

    try {
      // Upload setiap gambar dalam selectedImagePaths
      ServiceModel uploadSuccess = await UploadService().uploadDataJson(
        token: (await tokenManager.getToken())!,
        namaBarang: namaBarang,
        deskripsi: deskripsi,
        kategori: kategori,
        minPrice: minPrice,
        maxPrice: maxPrice,
        pathImages: imagePaths,
      );
      draftServices.add(uploadSuccess);
      notifyListeners();
    } catch (e) {
      log('jancokkkkkkkkkkk');
      log(e.toString());
      isLoading = false;
      notifyListeners();
      rethrow;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> updateData({
    required String namaBarang,
    required String deskripsi,
    required String kategori,
    required int minPrice,
    required int maxPrice,
    required List<String> imagePaths,
    required int id,
  }) async {
    // selectedImagePaths = imagePaths;
    log('coba update cokkk');
    isLoading = true;
    notifyListeners();

    try {
      // Upload setiap gambar dalam selectedImagePaths
      ServiceModel updateSuccess = await UpdateServiceSource().updateDataJson(
        token: (await tokenManager.getToken())!,
        namaBarang: namaBarang,
        deskripsi: deskripsi,
        kategori: kategori,
        minPrice: minPrice,
        maxPrice: maxPrice,
        pathImages: imagePaths,
        id: id,
      );

      // bool updated = false;
      _services = _services.map((service) {
        if (service.id == updateSuccess.id) {
          return updateSuccess; // Mengembalikan updateSuccess jika ID sama
        }
        return service; // Mengembalikan service yang tidak berubah
      }).toList(); // Mengubah Iterable menjadi List

      // draftServices.add(updateSuccess);
      // if (!updated) {
      //   draftServices.add(updateSuccess);
      // }
      notifyListeners();
    } catch (e) {
      log('jajal update cokkk');
      log(e.toString());
      isLoading = false;
      notifyListeners();
      rethrow;
    }

    isLoading = false;
    notifyListeners();
  }

  String getCategoryName(int categoryId) {
    CategoryModel selectedCategory = _categories.firstWhere(
      (element) => element.id == categoryId,
    );
    return selectedCategory.nameOfCategory;
  }

  int getOnReviewProduct() {
    return _draftServices
        .where((service) => service.status.toLowerCase() == 'pending')
        .length;
  }
}
