import 'package:logger/logger.dart';

class Log {
  static Logger _logger = Logger(
    printer:
        PrefixPrinter(PrettyPrinter(stackTraceBeginIndex: 5, methodCount: 1,lineLength: 100)),
  );

  static void v(dynamic message) {
    _logger.v(message);
  }

  static void d(dynamic message) {
    _logger.d(message);
  }

  static void i(dynamic message) {
    _logger.i(message);
  }

  static void w(dynamic message) {
    _logger.w(message);
  }

  static void e(dynamic message) {
    _logger.e(message);
  }

  static void wtf(dynamic message) {
    _logger.wtf(message);
  }
}
