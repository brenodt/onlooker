import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:watcher/watcher.dart';

class Onlooker {
  bool _processing = false;

  final _log = Logger('Onlooker');

  StreamSubscription? _watcher;
  StreamSubscription? _stdin;

  void watch(String dir, List<String> cmd, {String? cmdDir}) {
    assert(cmd.isNotEmpty);
    _log.info('Watching directory: ${Directory(dir).absolute.path}');
    stdout.writeln('''

onlooker spectate key commands:
· [q] 🛑 Quit 🛑
· [c] 🧼 Clear Terminal (Linux/MacOS only) 🧼

''');

    _log.config(
        'creating watcher with parameters: \n\t· Directory: "$dir"\n\t· Command: $cmd\n\t· Command Directory: "${cmdDir ?? dir}');
    final watcher = DirectoryWatcher(dir);

    _watcher = watcher.events.listen((event) {
      _log.fine('file change identified');
      if (_processing) return;
      _processing = true;
      Future.delayed(
          const Duration(seconds: 1), () => _process(cmdDir ?? dir, cmd));
    });

    stdin.lineMode = false;
    stdin.echoMode = false;
    _stdin = stdin.transform(utf8.decoder).listen((char) async {
      _log.finest('received keystroke from stdin: $char');
      if (char.toLowerCase() == 'q') await _quit();
      if (char.toLowerCase() == 'c') _clearTerminal();
    });
  }

  Future<void> _process(String cmdDir, List<String> cmd) async {
    _log.fine('processing command:\n\t$cmd\nfrom directory:\n\t$cmdDir');
    final res = await Process.run(
      cmd.first,
      cmd.length == 1 ? [] : cmd.sublist(1),
      workingDirectory: cmdDir,
      runInShell: true,
    );
    _log.fine(
        'command result:\n\t· Exit code: ${res.exitCode}\n\t· stderr: ${res.stderr}\n\t· stdout: ${res.stdout}');
    _processing = false;

    if (res.exitCode == 0) {
      stdout.writeln('>> ${res.stdout}');
    } else {
      stderr.writeln('>> ${res.stderr}');
      exit(res.exitCode);
    }
  }

  Future<void> _quit() async {
    await _watcher?.cancel();
    await _stdin?.cancel();
    stdout.writeln('Exiting onlooker...');
  }

  void _clearTerminal() {
    stdout.write(Process.runSync("clear", [], runInShell: true).stdout);
  }
}
