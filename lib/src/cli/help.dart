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
  
  EXAMPLE:
    onlooker spectate --dir . --cmd "echo Hello there"
  
  ARGUMENTS:
  --cmd,                The CLI command that will be executed. Wrap in quotes for multi-word commands.
  --cmd-dir,            The directory where the defined command should be executed. Defaults to the value of "dir".
  -d, --dir,            The directory tree to be watched.
  -v, --verbose,        Enable verbose logging
  -h, --help,           Show help
''';
}
