"""Dependency specific initialization."""

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")
load("@rules_python//python:pip.bzl", "pip_install")

def deps(repo_mapping = {}):
    pip_install(
        name = "pyprotoc_plugin_deps",
        requirements = "@com_github_reboot_dev_pyprotoc_plugin//:requirements.txt",
        repo_mapping = repo_mapping,
    )

    protobuf_deps()
