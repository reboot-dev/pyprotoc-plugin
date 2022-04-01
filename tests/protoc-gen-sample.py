#!/usr/bin/env python3
"""A sample plugin to demonstrate the use of pyprotoc-plugin."""
import os

from google.protobuf.descriptor_pb2 import FileDescriptorProto

from pyprotoc_plugin.helpers import load_template, add_template_path
from pyprotoc_plugin.plugins import ProtocPlugin


class SampleProtocPlugin(ProtocPlugin):

    def process_file(self, proto_file: FileDescriptorProto):
        proto_dir = os.path.dirname(proto_file.name)
        template_data = {
            'proto_package': proto_dir,
            'proto_module': os.path.basename(proto_file.name).replace('.proto', '_pb2'),
            'services': [
                {
                    'name': service.name,
                    'methods': [
                        {
                            'name': method.name,
                            'input_type': method.input_type,
                            'output_type': method.output_type,
                        }
                        for method in service.method
                    ],
                }
                for service in proto_file.service
            ]
        }

        output_file_name = proto_file.name.replace('.proto', '_sample_generated_out.py')

        template = load_template('sample_template.j2')
        content = template.render(**template_data)
        self.response.file.add(name=output_file_name, content=content)


if __name__ == '__main__':
    add_template_path(os.path.dirname(__file__))
    SampleProtocPlugin.execute()
