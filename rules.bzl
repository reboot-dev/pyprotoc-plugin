load("@rules_proto//proto:defs.bzl", "ProtoInfo")


def _get_proto_sources(context):
    proto_files = []

    for dependency in context.attr.deps:
        proto_files += [
            p
            for p in dependency[ProtoInfo].direct_sources
        ]

    return proto_files


def _generate_output_names(context, proto_file):

    file_path = proto_file.basename
    if proto_file.basename.endswith(".proto"):
        file_path = file_path[:-len(".proto")]

    output_file_names = [
        "%s%s%s" % (
            file_path,
            '' if extension.startswith('.') else '.',
            extension
        )
        for extension in context.attr._extensions
    ]

    return output_file_names


def _declare_outputs(context, proto_files):

    output_files = []

    for proto_file in proto_files:
        for output_file in _generate_output_names(context, proto_file):
            output_files.append(
                context.actions.declare_file(
                    output_file, sibling=proto_file
                )
            )
            # ToDo: Remove this limit
            # break

    return output_files


def _protoc_plugin_rule_implementation(context):
    proto_files = _get_proto_sources(context)
    output_files = _declare_outputs(context, proto_files)

    output_directory = context.genfiles_dir.path

    plugin_path = context.executable._plugin.path
    plugin_name = plugin_path.split("/")[-1]
    plugin_short_name = plugin_name.replace("protoc-gen-", "")

    args = [
        "--plugin=%s=%s%s" % (plugin_name,
                              context.label.workspace_root, plugin_path),
        "--%s_out" % plugin_short_name, output_directory,
    ]

    args += [
        proto_file.path
        for proto_file in proto_files
    ]

    context.actions.run_shell(
        outputs=output_files,
        inputs=proto_files,
        tools=[
            context.executable._protoc,
            context.executable._plugin,
        ],
        command=context.executable._protoc.path + " $@",
        arguments=args,
        use_default_shell_env=True,
    )

    return struct(
        files=depset(output_files),
    )


def create_protoc_plugin_rule(plugin_label, extensions):
    return rule(
        attrs={
            "deps": attr.label_list(
                mandatory=True,
                providers=[ProtoInfo],
            ),
            "_extensions": attr.string_list(
                default=extensions,
            ),
            "_plugin": attr.label(
                cfg="host",
                default=Label(plugin_label),
                # allow_single_file=True,
                executable=True,
            ),
            "_protoc": attr.label(
                cfg="host",
                default=Label("@com_google_protobuf//:protoc"),
                executable=True,
                allow_single_file=True,
            ),
        },
        output_to_genfiles=True,
        implementation=_protoc_plugin_rule_implementation,
    )
