part of 'onlooker_cli.dart';

ArgResults? parseArguments(List<String> arguments) {
  final onlookerParser = ArgParser()
    ..addOption(
      'dir',
      abbr: 'd',
      mandatory: true,
      help: 'the directory to be watched',
    )
    ..addOption(
      'cmd',
      mandatory: true,
      help: 'the command to be executed when something changes',
    )
    ..addOption(
      'cmd-dir',
      help: 'the directory where the defined command should be executed. Defaults to the value of "dir"',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      help: 'enable verbose logging',
      negatable: false,
    )
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'prints usage information',
      negatable: false,
    );

  final parser = ArgParser()
    ..addCommand('spectate', onlookerParser)
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'prints usage information',
      negatable: false,
    )
    ..addFlag(
      'version',
      abbr: 'v',
      help: 'prints current version',
      negatable: false,
    )
    ..addFlag(
      'info',
      abbr: 'i',
      help: 'print library info',
      negatable: false,
    );

  try {
    var result = parser.parse(arguments);
    return result;
  } on Error catch (e) {
    _terminate(
        'Invalid command input. see onlooker --help for info.', e.stackTrace);
    return null;
  }
}
