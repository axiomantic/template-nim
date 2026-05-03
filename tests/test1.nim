import unittest
import project_name

suite "smoke":
  test "hello returns non-empty string":
    check hello().len > 0

  test "version present":
    check projectVersion.len > 0
