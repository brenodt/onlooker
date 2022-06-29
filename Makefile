.PHONY: compile
compile:
	@echo "Compiling for Linux/MacOS..."
	@dart compile exe bin/main.dart -o onlooker

.PHONY: compile-win
compile-win:
	@echo "Compiling for Windows..."
	@dart compile exe bin/main.dart -o onlooker.exe

.PHONY: run-aot
run-aot:
	@echo "Compiling AOT snapshot..."
	@dart compile aot-snapshot bin/main.dart -o onlooker.aot
	@dartaotruntime onlooker.aot
