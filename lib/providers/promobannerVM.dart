import 'package:flutter/material.dart';
import 'package:learn/config/localDB.dart';
import 'package:learn/config/service.dart';
import 'package:learn/models/promotion_banner_model.dart';

class PrromoBannerVM with ChangeNotifier {
  final ServiceRepo _repo = ServiceRepo();
  List<PromotionBanneModel> pbannerList = [];

  PromotionBanneModel promotionBanneModel = PromotionBanneModel();

  LocalDatabaseService db = LocalDatabaseService();

  String? error;
  bool isloading = false;

  PrromoBannerVM() {
    getAllPromobanners();
  }
  Future<void> getAllPromobanners() async {
    isloading = true;
    error = null;
    notifyListeners();

    final boxOpen = await db.openBox("token");
    final token = db.fromDb(boxOpen, 'key');

    try {
      final response = await _repo.requist('promotion/banner', method: "GET");

      // Check if response and 'carts' key are valid
      if (response != null && response['data'] is List) {
        pbannerList = (response['data'] as List)
            .map((item) => PromotionBanneModel.fromJson(item))
            .toList();
      } else {
        error = 'No promo available or invalid response format.';
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  // make add to cart funtion
  Future<void> addBanner(int id) async {
    isloading = true;
    error = null;
    notifyListeners();
    final boxOpen = await db.openBox("token");
    final token = db.fromDb(boxOpen, 'key');
    try {
      final response = await _repo.requist('promotion/banner/add',
          method: "POST", body: promotionBanneModel.toJson());
      if (response != null) {
        getAllPromobanners();
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isloading = false;
      notifyListeners();
    }
  }
}
