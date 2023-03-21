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
