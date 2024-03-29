"""Adds repositories/archives."""

########################################################################
# DO NOT EDIT THIS FILE unless you are inside the
# https://github.com/reboot-dev/pyprotoc-plugin repository. If you
# encounter it anywhere else it is because it has been copied there in
# order to simplify adding transitive dependencies. If you want a
# different version of pyprotoc-plugin follow the Bazel build
# instructions at https://github.com/reboot-dev/pyprotoc-plugin.
########################################################################

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def repos(external = True, repo_mapping = {}):
    """Adds repositories/archives needed by pyprotoc-plugin

    Args:
          external: whether or not we're invoking this function as though
            though we're an external dependency
          repo_mapping: passed through to all other functions that expect/use
            repo_mapping, e.g., 'git_repository'
    """
    http_archive(
        name = "rules_python",
        sha256 = "9acc0944c94adb23fba1c9988b48768b1bacc6583b52a2586895c5b7491e2e31",
        strip_prefix = "rules_python-0.27.0",
        url = "https://github.com/bazelbuild/rules_python/releases/download/0.27.0/rules_python-0.27.0.tar.gz",
        repo_mapping = repo_mapping,
    )

    if "com_google_protobuf" not in native.existing_rules():
        git_repository(
            name = "com_google_protobuf",
            remote = "https://github.com/protocolbuffers/protobuf",
            # Release v3.19.4.
            # TODO(codingcanuck): Update to a newer release after
            # https://github.com/protocolbuffers/protobuf/issues/9688 is fixed.
            commit = "22d0e265de7d2b3d2e9a00d071313502e7d4cccf",
            shallow_since = "1643340956 -0800",
            repo_mapping = repo_mapping,
        )

    if external and "com_github_reboot_dev_pyprotoc_plugin" not in native.existing_rules():
        git_repository(
            name = "com_github_reboot_dev_pyprotoc_plugin",
            remote = "https://github.com/reboot-dev/pyprotoc-plugin",
            commit = "9f7a281670f03b77140c4437ac2a56b86f978af6",
            shallow_since = "1649038239 +0000",
            repo_mapping = repo_mapping,
        )
