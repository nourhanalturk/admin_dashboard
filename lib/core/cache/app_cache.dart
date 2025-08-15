/// A class defined for cache data thats used and when close app deleted
class CacheData {
  static String email = "";
  static String courseUid = "";
  static String instructorName = "";
  static String chatUid = "";
  static String userName = "";
  static String patientName = "";

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


  static void setChatUid(String uid) {
    chatUid = uid;
  }

  static String getChatUid() => chatUid;

  static void setPatientName(String value) => patientName = value;

  static String getPatientName() => patientName;
}
