import 'package:flutter/material.dart';
import 'package:learn/config/localDB.dart';
import 'package:learn/config/service.dart';
import 'package:learn/models/deal_of_day_model.dart';


class DealOFDayVM with ChangeNotifier {
  final ServiceRepo _repo = ServiceRepo();
  List<DealOfDayModel> dealdayList = [];

  DealOfDayModel dealOfDayModel = DealOfDayModel();

  LocalDatabaseService db = LocalDatabaseService();

  String? error;
  bool isloading = false;

  DealOFDayVM() {
    getAllDealOdday();
  }
  Future<void> getAllDealOdday() async {
    isloading = true;
    error = null;
    notifyListeners();

    final boxOpen = await db.openBox("token");
    final token = db.fromDb(boxOpen, 'key');

    try {
      final response = await _repo.requist('deal', method: "GET");

      // Check if response and 'carts' key are valid
      if (response != null && response['data'] is List) {
        dealdayList = (response['data'] as List)
            .map((item) => DealOfDayModel.fromJson(item))
            .toList();
      } else {
        error = 'No deal od day available or invalid response format.';
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  // make add to cart funtion
  Future<void> addDealOfDay() async {
    isloading = true;
    error = null;
    notifyListeners();
    final boxOpen = await db.openBox("token");
    final token = db.fromDb(boxOpen, 'key');
    try {
      final response = await _repo.requist('deal/add',
          method: "POST", body: dealOfDayModel.toJson());
      if (response != null) {
        getAllDealOdday();
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isloading = false;
      notifyListeners();
    }
  }
}
