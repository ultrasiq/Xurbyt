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
DESTINY_API_KEY = secret.decrypt("AV6+xWcEwljnSZth3ehEP25KTp+nAGMS6DUWflIhWRBFueZIBmD4C00meZgjHLzZHdpBkpcfMI5VuWlR3lek2xLV1jEPa4LAja37bsTjXs/BooXAUrKRtM04V19JpW9zYVjtne1lKTqC/EHi9BNTWKESl3s202sKQyplmifhgL9nrm5yD7g=")
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
=======
load("http.star", "http")

api_key = "69ba2f4b23824a048a8374ba5f1679b4"
xur_data = xur_location_inventory(api_key)

def get_xur_data(api_key):
    url = "https://www.bungie.net/Platform/Destiny2/Vendors/?components=Vendors"
    headers = {"X-API-Key": 69ba2f4b23824a048a8374ba5f1679b4}
    response = http.get(url, headers=headers)

    if response.status_code != 200:
        fail("Failed to get vendor data from Bungie API")

    data = response.json()
    for vendor in data["Response"]["vendors"]["data"].values():
        if vendor["hash"] == 2190858386: # Xur's hash
            return vendor

    fail("Failed to find Xur in vendor data")

def xur_location_inventory(api_key):
    xur_data = get_xur_data(api_key)

    location = xur_data["locations"][0]["displayProperties"]["name"]
    inventory = []
    for sale_item in xur_data["saleItemCategories"][0]["saleItems"]:
        item = {
            "name": sale_item["item"]["displayProperties"]["name"],
            "description": sale_item["item"]["displayProperties"]["description"],
            "icon": sale_item["item"]["displayProperties"]["icon"],
            "cost": sale_item["costs"][0]["quantity"],
            "currency": sale_item["costs"][0]["item"]["displayProperties"]["name"],
        }
        inventory.append(item)

    return {"location": location, "inventory": inventory}

print("Xur is currently at", xur_data["location"])
print("Xur's inventory:")
for item in xur_data["inventory"]:
    print("-", item["name"], "(cost:", item["cost"], item["currency"], ")")
