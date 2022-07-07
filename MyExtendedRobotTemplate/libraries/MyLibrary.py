from robot.api import logger
import requests,json

class MyLibrary:
    """Give this library a proper name and document it."""

    def example_python_keyword(self):
        logger.info("This is Python!")

    def call_weather_api(self, geolocation):
        endpoint="https://api.weather.gov/points/{0},{1}".format(geolocation[0],geolocation[1])
        response= requests.get(endpoint)
        if response.status_code == 200:
            parse_weather_api_content(response.json())
        else:
            print("API Error: {0}".format(response.status_code))


def parse_weather_api_content(content):
    print("Temperature Low: {0}".format(content['properties']['gridX']))
    print("Temperature High: {0}".format(content['properties']['gridY']))

