import requests

API_KEY = "69ba2f4b23824a048a8374ba5f1679b4"
HEADERS = {"X-API-Key": API_KEY}
BASE_URL = "https://www.bungie.net/Platform/Destiny2"

def get_vendors_by_location(location_index):
    url = f"{BASE_URL}/Vendors/?components=Vendors,ItemDetails"
    response = requests.get(url, headers=HEADERS)
    if response.status_code == 200:
        data = response.json()["Response"]["vendors"]["data"]
        vendors = data.values()
        for vendor in vendors:
            if vendor["vendorLocationIndex"] == location_index:
                return vendor
    else:
        raise Exception(f"Error {response.status_code}: {response.json()['ErrorStatus']}")

# Example usage: get the vendor at location index 102
vendor = get_vendors_by_location(102)
print(vendor["displayProperties"]["name"])
print(vendor["displayProperties"]["description"])
