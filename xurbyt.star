"""
Applet: Xurbyt
Summary: Location tracker for Xur
Description: Location tracker for the Destiny 2 NPC Exoctic equipment vender Xur.
Author: ultrasiq
"""

load("http.star", "http")
load("render.star", "render")
load("secret.star", "secret")

# NOTE: Encrypt your API token using pixlet encrypt i.e. `pixlet encrypt myapp "my-super-secret-auth-token"`
# DESTINY_API_KEY = secret.decrypt(<Then enter your encrypted token here, and uncomment this line>)
HEADERS = {"X-API-Key": DESTINY_API_KEY}
BASE_URL = "https://www.bungie.net/Platform/Destiny2"


def get_vendors_by_location(location_index):
    url = f"{BASE_URL}/Vendors/?components=Vendors,ItemDetails"
    response = http.get(url, headers=HEADERS)

    if res.status_code != 200:
        return render.Root(
            child=render.Text("Xur is still traveling to his next LZ"),
        )

    if response.status_code == 200:
        data = response.json()["Response"]["vendors"]["data"]
        vendors = data.values()
        for vendor in vendors:
            if vendor["vendorLocationIndex"] == location_index:
                # Once you have the details you want to display, you can using the Starlark render method, left an example above
                return vendor


# Example usage: get the vendor at location index 102
vendor = get_vendors_by_location(102)
print(vendor["displayProperties"]["name"])
print(vendor["displayProperties"]["description"])
