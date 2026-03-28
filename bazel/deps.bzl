"""Dependency specific initialization."""

load("@pyprotoc_plugin_pypi//:requirements.bzl", pypi_deps = "install_deps")
load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies")

def deps(repo_mapping = {}):
    rules_proto_dependencies()

    pypi_deps(repo_mapping = repo_mapping)
