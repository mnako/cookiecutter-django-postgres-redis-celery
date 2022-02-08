from django.test import TestCase


class CommonViewsTestCase(TestCase):

    def test_get_default_urlconf_should_return_200(self):
        response = self.client.get("")

        self.assertEqual(response.status_code, 200)
