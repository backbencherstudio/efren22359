class ApiEndpoints {
  ApiEndpoints._();
  static const String baseUrl =
      'https://action-payroll-twiki-precise.trycloudflare.com/api';

  static const String imageBaseurl =
      'https://action-payroll-twiki-precise.trycloudflare.com';

  static const String register = '$baseUrl/auth/register';
  static const String emailVerification = '$baseUrl/auth/verify-email';
  static const String login = '$baseUrl/auth/login';
  static const String forgetPassword = '$baseUrl/auth/forgot-password';
  static const String resetPassOtp = '$baseUrl/auth/validate-otp';
  static const String resetPassword = '$baseUrl/auth/reset-password';
  static const String getAllPost = '$baseUrl/create-post/all-posts';
  static const String parentCategory = '$baseUrl/add-management/parents';
  static String subCategoryByParentId(String parentId) =>
      '$baseUrl/add-management/categories/$parentId';
  static const String getAllAds = '$baseUrl/add-management/all-posts';
  static const String getPendingAds = '$baseUrl/add-management/pending-posts';
  static const String createPost = '$baseUrl/create-post/create-post';
  static const String getMe = '$baseUrl/auth/me';

  // chatting section

  static const String getAllUser = '$baseUrl/chat/user';

  static const String createGeneralConversation =
      '$baseUrl/chat/conversation/general';

  static const String createServiceBasedConversation =
      '$baseUrl/chat/conversation/ad-responses';

  static const String getConversationMetadata =
      '$baseUrl/chat/conversation/metadata';

  static const String getGeneralConversationList =
      '$baseUrl/chat/conversation/general';

  static const String getCategoryMetadata =
      '$baseUrl/chat/conversation/ad-responses/metadata';
  static String getCategoryBasedConversation(String serviceName) =>
      '$baseUrl/chat/conversation/ad-responses/$serviceName';

  static String getConversationMessage(String conversationId) =>
      '$baseUrl/chat/conversation/$conversationId/messages?page';

  static const sendMessage = '$baseUrl/chat/message';

  static String conversationHeaderDetail(String conversationId) =>
      '$baseUrl/chat/conversation/$conversationId';

  // Chatting Section End

  static String getOnePost(String postId) =>
      '$baseUrl/create-post/post/$postId';
  static String reportPostById(String postId) =>
      '$baseUrl/report/create-report/$postId';
  static String subCategory(String parentCategoryId) =>
      '$baseUrl/add-management/categories/$parentCategoryId';
  static String favoritePost(String postId) =>
      '$baseUrl/create-post/favorite/$postId';
  static String getPostsByCategoryId(String categoryId) =>
      '$baseUrl/create-post/$categoryId';
  static const String disableAccount = '$baseUrl/auth/disabled-account';
  static const String getFavouritePost = '$baseUrl/create-post/favorite-posts';
  static const String getReportTypeList = '$baseUrl/report/report-types';
  static const String getReportDetailsList =
      '$baseUrl/report/report-categories';
  static const String getUserPostsDetailsList = '$baseUrl/create-post/allposts';
  static const String updateUser = '$baseUrl/auth/update';
  static String updatePost(String postId) => '$baseUrl/create-post/$postId';
  static String getOneUserById(String UserID) => '$baseUrl/auth/user/$UserID';
}
