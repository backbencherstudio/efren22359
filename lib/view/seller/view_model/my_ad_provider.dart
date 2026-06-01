import 'package:flutter/material.dart';
import 'package:local/cors/constant/api_end_point.dart';
import 'package:local/view/seller/model/ad/ad_model.dart';
import '../../../cors/services/api_services.dart';
import '../model/favorite/favorite_post_model.dart';

class MyAdProvider with ChangeNotifier {
  MyAdProvider() {
    getMyAds();
    getFavoritePost();
  }
  int _selectedSegment = 0;
  String _selectedFilter = 'All';
  String _selectedAdTitle = '';
  final List<String> _filters = [
    'All',
    'Active',
    'Pause',
    'Pending',
    'Rejected',
    'Expired',
  ];

  int get selectedSegment => _selectedSegment;
  String get selectedFilter => _selectedFilter;
  String get selectedAdTitle => _selectedAdTitle;
  List<String> get filters => _filters;

  List<dynamic> get adListings {
    List<dynamic> ads = [];
    if (_selectedSegment == 0) {
      if (_selectedFilter == 'All') {
        ads = _myAllAds;
      } else if (_selectedFilter == 'Active') {
        ads = _myActiveAds;
      } else if (_selectedFilter == 'Pause') {
        ads = _myPauseAds;
      } else if (_selectedFilter == 'Rejected') {
        ads = _myRejectedAds;
      } else if (_selectedFilter == 'Pending') {
        ads = _myPendingAds;
      } else if (_selectedFilter == 'Expired') {
        ads = _myExpiredAds;
      } else {
        ads = _myAllAds;
      }
    } else {
      ads = _myActiveAds;
    }
    return ads;
  }

  void changeSegment(int index) {
    _selectedSegment = index;
    _selectedFilter = 'All';
    notifyListeners();
  }

  void changeFilter(String filter) {
    if (_selectedSegment == 0) {
      _selectedFilter = filter;
      notifyListeners();
    }
  }

  void setSelectedAdTitle(String title) {
    _selectedAdTitle = title;
    notifyListeners();
  }

  bool _isLoading = false;
  bool _isLoadingPendings = false;
  bool get isLoading => _isLoading;
  bool get isLoadingPendings => _isLoadingPendings;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<AdModel> _myAllAds = [];
  List<AdModel> _myActiveAds = [];
  List<AdModel> _myPendingAds = [];
  List<AdModel> _myPauseAds = [];
  List<AdModel> _myRejectedAds = [];
  List<AdModel> _myExpiredAds = [];
  List<AdModel> get myAllAds => _myAllAds;
  List<AdModel> get myActiveAds => _myActiveAds;
  List<AdModel> get myPendingAds => _myPendingAds;
  List<AdModel> get myPauseAds => _myPauseAds;
  List<AdModel> get myRejectedAds => _myRejectedAds;
  List<AdModel> get myExpiredAds => _myExpiredAds;

  final ApiService _apiService = ApiService();

  Future<void> getMyAds() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _apiService.get(ApiEndpoints.getAllAds);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'] as List;
        _myAllAds = data.map((e) => AdModel.fromJson(e)).toList();
        _myActiveAds = _myAllAds.where((ad) => ad.status == 'active').toList();
        _myPauseAds = _myAllAds.where((ad) => ad.status == 'pause').toList();
        _myRejectedAds =
            _myAllAds.where((ad) => ad.status == 'rejected').toList();
        _myExpiredAds =
            _myAllAds.where((ad) => ad.status == 'expired').toList();
        _errorMessage = '';
        debugPrint("The my ads length is: ${_myAllAds.length}");
        debugPrint("The my active ads length is: ${_myActiveAds.length}");
        debugPrint("The my pause ads length is: ${_myPauseAds.length}");
        debugPrint("The my rejected ads length is: ${_myRejectedAds.length}");
        debugPrint("The my expired ads length is: ${_myExpiredAds.length}");
      } else {
        _errorMessage = 'Failed to fetch ads';
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getMyPendingAds() async {
    try {
      _isLoadingPendings = true;
      notifyListeners();

      final response = await _apiService.get(ApiEndpoints.getPendingAds);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'] as List;
        _myPendingAds = data.map((e) => AdModel.fromJson(e)).toList();
        _errorMessage = '';
        debugPrint("The my pending ads length is: ${_myRejectedAds.length}");
      } else {
        _errorMessage = 'Failed to fetch ads';
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
    } finally {
      _isLoadingPendings = false;
      notifyListeners();
    }
  }

  List<FavoritePostModel> _favoritePostList = [];
  List<FavoritePostModel> get favoritePostList => _favoritePostList;

  Future<void> getFavoritePost() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _apiService.get(ApiEndpoints.getFavouritePost);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as List;
        _favoritePostList =
            data.map((e) => FavoritePostModel.fromJson(e)).toList();
        _errorMessage = response.data['message'];

        debugPrint("The favorite post length is: ${_favoritePostList.length}");
      } else {
        _errorMessage = 'Failed to fetch favorite post';
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
    }
  }
}
