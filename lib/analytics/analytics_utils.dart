class AnalyticsUtils{
  static bool isNotNullOrEmpty(String? value) {
    return value != null && value.isNotEmpty && value != "null";
  }
}