import 'package:flutter/material.dart';
import 'package:local/model/report/report_model.dart';

import '../../cors/constant/api_end_point.dart';
import '../../cors/services/api_services.dart';

class ReportPostProvider with ChangeNotifier {

  List<ReportModel> _reportTypeList = [];
  List<ReportModel> get reportTypeList => _reportTypeList;

  List<ReportModel> _reportDetailList = [];
  List<ReportModel> get reportDetailList => _reportDetailList;

  String? reportType;
  String? reportTypeId;
  String? reportDetail;
  String? reportDetailId;

  void setReportType(String type) {
    reportType = type;
    notifyListeners();
  }

  void setReportTypeId(String typeId) {
    reportTypeId = typeId;
    notifyListeners();
  }

  void setReportDetail(String detail) {
    reportDetail = detail;
    notifyListeners();
  }

  void setReportDetailsId(String id) {
    reportDetailId = id;
    notifyListeners();
  }

  void resetReport() {
    reportTypeId = null;
    reportDetail = null;
    reportDetailId = null;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final ApiService _apiService = ApiService();

  Future<void> getReportTypeList() async {
    try {
      final response = await _apiService.get(ApiEndpoints.getReportTypeList);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'] as List;
        _reportTypeList = data.map((e) => ReportModel.fromJson(e)).toList();
        _errorMessage = response.data['message'];
        debugPrint("The report type length is: ${_reportTypeList.length}");
      } else {
        _errorMessage = 'Failed to fetch report type';
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
    }
  }

  Future<void> getReportDetailsList() async {
    try {
      final response = await _apiService.get(ApiEndpoints.getReportDetailsList);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'] as List;
        _reportDetailList = data.map((e) => ReportModel.fromJson(e)).toList();
        _errorMessage = response.data['message'];
        debugPrint("The report detail length is: ${_reportDetailList.length}");
      } else {
        _errorMessage = 'Failed to fetch report details';
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
    }
  }

  Future<bool> reportPost(String postId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final reportData = {
      'report_type': reportTypeId,
      'report_category': reportDetailId,
      'reason': reportDetail,
    };

    try {
      final response = await _apiService.post(ApiEndpoints.reportPostById(postId), data: reportData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        notifyListeners();
        _errorMessage = "Report submitted successfully";
        return true;
      } else {
        _errorMessage = "Failed to submit report";
      }
    } catch (error) {
      _errorMessage = "Error: $error";
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }
}