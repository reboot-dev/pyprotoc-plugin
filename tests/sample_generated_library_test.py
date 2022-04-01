from tests.sample_service_sample_generated_out import SampleServiceCustomClient
from tests import sample_service_pb2

import unittest

class TestSampleGeneratedLibrary(unittest.TestCase):
    """Tests the sample python client we generated for a proto service."""

    def test_generated_client(self):
        client = SampleServiceCustomClient()
        # We can call a generated (no-op) method.
        client.CallSampleMethod(sample_service_pb2.SampleRequest())

if __name__ == '__main__':
    unittest.main()
