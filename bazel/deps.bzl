"""Dependency specific initialization."""

load("@rules_python//python:pip.bzl", "pip_install")

def deps(repo_mapping = {}):
    pip_install(
        name="pyprotoc_plugin_deps",
        requirements="@com_github_reboot_dev_pyprotoc_plugin//:requirements.txt",
    )
