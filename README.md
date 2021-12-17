## JSON

JSON using `@dynamicMemberLookup`, which allows us to write more natural code like : `json[0]?.address?.city?.stringValue` just like JavaScript does.

## Example

```swift
func jsonData() -> Data? {
    let jsonStr = """
     [
         {
             "name": "Jewelz",
             "email": "example@gmil.com",
             "address": {
                 "street": "reai road.",
                 "city": "Zhe Jiang"
             }
         },
         {
             "name": "Tom",
             "email": "tomcat@gmil.com",
             "address": {
                 "street": "big mouse road.",
                 "city": "An Hui"
             }
         },
         {
             "name": "Jo",
             "email": "jo@gmil.com",
             "address": {
                 "street": "Joo road.",
                 "city": "Shang Hai"
             }
         }
     ]
    """
    return jsonStr.data(using: .utf8)
}

if let data = jsonData(), let json = JSON(data: data) {
    let name = json[0]?.name?.stringValue
    print("name: ", name) // Prints: name:  Optional("Jewelz")
    
    let city = json[0]?.address?.city?.stringValue
    print("city: ", city) // Prints: city:  Optional("Zhe Jiang")
}

```
