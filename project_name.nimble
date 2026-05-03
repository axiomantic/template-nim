# project_name.nimble

# Package

version = "0.0.1"
author = "Axiomantic"
description = "PROJECT DESCRIPTION HERE"
license = "MIT"
srcDir = "src"
installExt = @["nim"]

# Dependencies

requires "nim >= 2.0.0"

# Tasks

task test, "Run tests":
  exec "nim r --hints:off tests/test1.nim"
