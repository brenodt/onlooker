part of 'onlooker_cli.dart';

void _terminate(String message, [dynamic stackTrace]) {
  Logger.root.log(Level('ERROR', 1100), message, null, stackTrace);
  exitCode = 2;
  exit(2);
}

void _printInfo() => stdout.writeln('''
ONLOOKER:
  A command-line tool to automate command execution on source change.
  
  VERSION           $packageVersion
  AUTHOR            Breno Teodoro (https://github.com/brenodt)
  HOMEPAGE          https://github.com/brenodt/onlooker
  
  see onlooker --help for more available commands.
''');

void _printVersion() => stdout.writeln(packageVersion);

extension _ArgExtension on List<String> {
  bool hasArg(String flag, String abbr) {
    return contains('--$flag') || contains('-$abbr');
  }
}
