part of '../utils.dart';

final log = Logger(printer: CustomPrinter(), level: Level.verbose, filter: CustomFilter());

class CustomFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => true;
}

String logText = "";

class CustomPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    var color = {
          Level.verbose: AnsiColor.fg(AnsiColor.grey(0.5)),
          Level.debug: AnsiColor.fg(6),
          Level.info: AnsiColor.fg(2),
          Level.warning: AnsiColor.fg(3),
          Level.error: AnsiColor.fg(196),
          Level.wtf: AnsiColor.fg(199),
        }[event.level] ??
        AnsiColor.fg(AnsiColor.grey(0.5));
    var prefix = {
          Level.verbose: "[VERB]",
          Level.debug: "[DEBG]",
          Level.info: "[INFO]",
          Level.warning: "[WARN]",
          Level.error: "[ERR!]",
          Level.wtf: "[WTF!]",
        }[event.level] ??
        "[VERB]";
    logText += '$prefix ${event.message}\n';
    return [color('$prefix ${event.message}')];
  }
}
