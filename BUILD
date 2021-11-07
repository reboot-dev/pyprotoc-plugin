load("@pip_deps//:requirements.bzl", "requirement")

py_library(
    name='pyprotoc_plugin',
    srcs=glob(['pyprotoc_plugin/**/*.py']),
    srcs_version='PY3',
    deps=[
        requirement("Jinja2"),
        requirement("protobuf"),
    ],
    visibility=["//visibility:public"],
)

py_test(
    name='library_tests',
    srcs=[
        'tests/library_tests.py'
    ],
    deps=[
        ':pyprotoc_plugin'
    ],
)
