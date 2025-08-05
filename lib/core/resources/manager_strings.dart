import 'package:easy_localization/easy_localization.dart';

/// A class defined for strings in the app
class ManagerStrings {
  /// Config Strings
  static String get noRouteFound => tr('noRouteFound');

  static String get success => tr('success');

  static String get skip => tr('skip');

  static String get question => tr('question');

  static String get noContent => tr('noContent');

  static String get second => tr('second');

  static String get score => tr('yourScore');

  static String get badRequest => tr('badRequest');

  static String get forbidden => tr('forbidden');

  static String get unAuthorized => tr('unAuthorized');

  static String get notFound => tr('notFound');

  static String get internalServerError => tr('internalServerError');

  static String get invalidEmptyName => tr('invalidEmptyName');

  static String get nameShouldNotContainNumbers =>
      tr('nameShouldNotContainNumbers');

  static String get invalidName => tr('invalidName');

  static String get connectTimeOut => tr('connectTimeOut');

  static String get cancel => tr('cancel');

  static String get receiveTimeOut => tr('receiveTimeOut');

  static String get sendTimeOut => tr('sendTimeOut');

  static String get cacheError => tr('cacheError');

  static String get noInternetConnection => tr('noInternetConnection');

  static String get unknown => tr('unknown');

  static String get sessionFinished => tr('sessionFinished');

  static String get invalidEmptyEmail => tr('invalidEmptyEmail');

  static String get invalidEmail => tr('invalidEmail');

  static String get doYouWantToChangeIt => tr('doYouWantToChangeIt');

  static String get invalidPasswordLength => tr('invalidEmptyPassword');

  static String get invalidPasswordUpper => tr('invalidPasswordUpper');

  static String get invalidPasswordSymbol => tr('invalidPasswordSymbol');

  static String get fullName => tr('fullName');

  static String get letsPlayQuiz => tr('letsPlayQuiz');

  static String get letsStartQuiz => tr('letsStartQuiz');

  static String get enterYourInformation => tr('enterYourInformation');

  /// Errors
  static String get sendMessageError => tr(' Failed to send the message');

  static String get timeoutError => tr(' Timeout reached, message not sent');

  static String get serverResponseError =>
      tr(' Failed to send the message, try again');

  /// Success
  static String get messageSent => tr('Message sent successfully');

  /// General
  static String get serverResponse => tr('Server response: ');

  static String get retrySending => tr('Failed to send the message');

  static String get tryAgain => tr('Error!');

  static String get messageToInstructor => tr('messageToInstructor');

  static String get chatHere => tr('chatHere');

  static String get howDoYouWantToMessageTheInstructor =>
      tr('howDoYouWantToMessageTheInstructor');

  static String get messageViaWhatsapp => tr('messageViaWhatsapp');

  static String get messageViaInstagram => tr('messageViaInstagram');

  static String get messageViaEmail => tr('messageViaEmail');
}
