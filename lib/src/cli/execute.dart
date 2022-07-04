part of 'onlooker_cli.dart';

const packageVersion = '1.0.0';

void execute(ArgResults rootCommand) {
  if (rootCommand.command == null) {
    _processArgs(rootCommand.arguments);
  } else {
    switch (rootCommand.command!.name) {
      case 'spectate':
        _processSpectateCommand(rootCommand.command!, rootCommand);
        break;
      default:
        _terminate('Command not found. Please check onlooker --help');
    }
  }
}

void _processArgs(List<String> arguments) {
  if (arguments.hasArg('help', 'h')) {
    stdout.writeln(HelpManuals.defaultHelp);
  } else if (arguments.hasArg('verbose', 'v')) {
    _printVersion();
  } else if (arguments.hasArg('info', 'i')) {
    _printInfo();
  } else {
    stdout.writeln(HelpManuals.defaultHelp);
  }
}

void _processSpectateCommand(ArgResults command, ArgResults root) async {
  if (command.arguments.hasArg('help', 'h')) {
    stdout.writeln(HelpManuals.spectateHelp);
  } else {
    var verbose = command.arguments.hasArg('verbose', 'v');
    Logger.root.level = verbose ? Level.ALL : Level.INFO;

    final onlooker = Onlooker();
    onlooker.watch(command['dir'], (command['cmd'] as String).split(' '), cmdDir: command['cmd-dir']);
  }
}
