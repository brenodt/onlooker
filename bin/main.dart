import 'dart:io';

import 'package:logging/logging.dart';
import 'package:onlooker/src/cli/onlooker_cli.dart' as cli;

void main(List<String> arguments) {
  setupLogging();
  exitCode = 0;

  final argResults = cli.parseArguments(arguments);
  if (argResults == null) return;
  cli.execute(argResults);
}

void setupLogging() {
  Logger.root.level = Level.CONFIG; // defaults to Level.CONFIG
  recordStackTraceAtLevel = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (record.level == Level.SEVERE) {
      stderr.writeln('[${record.level.name}] ${record.message}');
    } else {
      stdout.writeln('[${record.level.name}] ${record.message}');
    }
  });
}
