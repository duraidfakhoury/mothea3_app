class ApisUrls {
  static ApisUrls? _instance;
  ApisUrls._();
  factory ApisUrls() => _instance ??= ApisUrls._();

  late String _baseUrl;

  void initBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  /// class [ApisUrls] contains all URLs to external services, services,
  /// or APIs, according to the following figure
  ///
  /// add new APIs URL in this way:
  /// EX: static  String get {verb}featureName => '$_baseApiUrl/{route}';

  /// [_baseApiUrl] base API url
  String get _baseApiUrl => '$_baseUrl/api';

  /// [_baseImagesUrl] base Images Url
  //   String get _baseImagesUrl => '$_baseUrl/uploads';
  String baseImagesUrl(String url) => url;

  /// Auth Feature APIs
  String get login => '$_baseApiUrl/login';
  String get register => '$_baseApiUrl/register';


  /// Complaint Feature APIs
  String get getAgencies => '$_baseApiUrl/agencies';
  String get addComplaint => '$_baseApiUrl/complaints';
  String getComplaints(String citizenId) =>
      '$_baseApiUrl/complaints?citizenId=$citizenId';
}
