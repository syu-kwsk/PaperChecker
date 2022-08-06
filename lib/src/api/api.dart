class CiNiiPaperAPI {
  CiNiiPaperAPI(this.apiKey);
  final String apiKey;

  static const String _apiBaseUrl = "ci.nii.ac.jp";
  static const String _apiPath = "/opensearch";

  Uri papers(String keyword) => _buildUri(
    endpoint: "/search",
    parametersBuilder: () => queryParameters(keyword),
  );

  Uri authors(String name) => _buildUri(
    endpoint: "/author",
    parametersBuilder: () => queryParameters(name),
  );

  Uri _buildUri({
    required String endpoint,
    required Map<String, dynamic> Function() parametersBuilder,
  }) {
    return Uri(
      scheme: "https",
      host: _apiBaseUrl,
      path: "$_apiPath$endpoint",
      queryParameters: parametersBuilder(),
    );
  }

  Map<String, dynamic> queryParameters(String query) => {
    "q": query,
    "appid": apiKey,
    "format": "json",
    "count": 20,
  };
}
