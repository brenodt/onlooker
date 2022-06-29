part of 'onlooker_cli.dart';

class HelpManuals {
  static const defaultHelp = '''
Onlooker CLI Tool
  Onlooker is a command-line tool to automate command execution on source change.
  
  COMMANDS:
  
  spectate              Watch for file changes and trigger a command.
  
  ARGUMENTS:
  -h, --help            Show help
  -i, --info            Show info
  -v, --version         Show current version
''';

  static const spectateHelp = '''
onlooker spectate --dir <directory> --cmd <command>
  whenever a change happens on <directory>, the <command> will be executed
  
  ARGUMENTS:
  --cmd,                The CLI command that will be executed. (Array)
  -d, --dir,            The directory tree to be watched.
  -v, --verbose,        Enable verbose logging
  -h, --help,           Show help
''';
}
