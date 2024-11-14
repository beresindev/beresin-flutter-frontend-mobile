import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_beresin/common/token_manager.dart';
import 'package:mobile_beresin/models/category_model.dart';
import 'package:mobile_beresin/models/service_model.dart';
import 'package:mobile_beresin/services/service_source.dart';
import 'package:mobile_beresin/services/upload_service_source.dart';

class ServiceProvider with ChangeNotifier {
  final tokenManager = TokenManager();

  List<ServiceModel> _draftServices = [];
  List<ServiceModel> get draftServices => _draftServices;

  List<ServiceModel> _services = [];
  List<ServiceModel> get services => _services;

  String _searchKeyword = '';
  String get searchKeyword => _searchKeyword;

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

  Future<bool> getDraftServices() async {
    isLoading = true;
    notifyListeners();
    try {
      log("masuk get draft service");
      List<ServiceModel> result = await ServiceSource().getDraftService(
        token: (await tokenManager.getToken())!,
      );
      _draftServices = result;
      isLoading = false;
      notifyListeners();
      log("draft service get");
      return true;
    } on SocketException {
      _draftServices = [];
      isLoading = false;
      notifyListeners();
      // rethrow;
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

  Future<bool> deleteSaving({
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
        pathImages: imagePaths,
      );
      draftServices.add(uploadSuccess);
      notifyListeners();
    } catch (e) {
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
