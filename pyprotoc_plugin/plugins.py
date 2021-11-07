import sys

from google.protobuf.compiler import plugin_pb2 as plugin
from google.protobuf.descriptor_pb2 import FileDescriptorProto


class ProtocPlugin(object):

    @classmethod
    def execute(cls, *args, **kwargs):
        plugin = cls(*args, **kwargs)
        plugin.setup()
        plugin.run()
        plugin.finalize()

    def setup(self) -> None:
        self.request = plugin.CodeGeneratorRequest.FromString(
            sys.stdin.buffer.read()
        )

        self.response = plugin.CodeGeneratorResponse()

    def finalize(self) -> None:
        sys.stdout.buffer.write(
            self.response.SerializeToString()
        )

    def run(self) -> None:
        for proto_file in self.request.proto_file:
            self.process_file(proto_file)

    def process_file(self, proto_file: FileDescriptorProto) -> None:
        raise NotImplementedError
