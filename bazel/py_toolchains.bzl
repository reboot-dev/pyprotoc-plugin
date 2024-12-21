"""Defines a local python toolchain for use in rules_python."""

load("@rules_proto//proto:toolchains.bzl", "rules_proto_toolchains")
load("@rules_python//python:repositories.bzl", "py_repositories", "python_register_toolchains")

def py_toolchains(repo_mapping = {}):
    py_repositories()

    python_register_toolchains(
        name = "python3_10_12",
        python_version = "3.10.12",
        repo_mapping = repo_mapping,
    )

    # TODO: not really a Python toolchain?
    rules_proto_toolchains()
