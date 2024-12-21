"""Defines local PyPI-based repositories. Their deps
should be installed later in WORKSPACE file to be accessible.
`pip_parse` takes a `requirements_lock` file as input, which is
generated by the `bazel run :requirements.update` command."""

load("@rules_python//python:pip.bzl", "pip_parse")

def pypi_repos():
    pip_parse(
        name = "pyprotoc_plugin_pypi",
        python_interpreter_target = "@python3_10_12_host//:python",
        requirements_lock = "@com_github_reboot_dev_pyprotoc_plugin//:requirements_lock.txt",
    )
