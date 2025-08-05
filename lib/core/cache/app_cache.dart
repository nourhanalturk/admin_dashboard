/// A class defined for cache data thats used and when close app deleted
class CacheData {
  static String email = "";
  static String courseUid = "";
  static String instructorName = "";

  static void setInstructorName({required String instName}) {
    instructorName = instName;
  }

  static String getInstructorName() {
    return instructorName;
  }

  /// Set the email to cache as a static
  static void setEmail({
    required String value,
  }) {
    email = value;
  }

  /// Get the email from the cache
  static String getEmail() {
    return email;
  }

  void setCourseUid({
    required String value,
  }) {
    courseUid = value;
  }

  String getCourseUid() {
    return courseUid;
  }
}
