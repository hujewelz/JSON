import Foundation

@dynamicMemberLookup
enum JSON {
    case int(Int)
    case string(String)
    case array(Array<JSON>)
    case dictionary(Dictionary<String, JSON>)
}


extension JSON {
    init?(data: Data) {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else { return nil }
        if let intValue = json as? Int {
            self = .init(intValue)
        } else if let strValue = json as? String {
            self = .init(strValue)
        } else if let arr = json as? [Any] {
            self = .init(arr)
        } else if let dict = json as? [String: Any] {
            self = .init(dict)
        } else {
            return nil
        }
    }
    
    init(_ value: Int) {
        self = .int(value)
    }
    
    init(_ value: String) {
        self = .string(value)
    }
    
    init(_ value: [Any]) {
        let array = value.compactMap { item -> JSON? in
            if let aInt = item as? Int {
                return .int(aInt)
            } else if let str = item as? String {
                return .string(str)
            } else if let arr = item as? [Any] {
                return .init(arr)
            } else if let dict = item as? [String: Any] {
                return .init(dict)
            }
            return nil
        }
        self = .array(array)
    }
    
    init(_ value: [String: Any]) {
        let dict = value.compactMapValues { item -> JSON? in
            if let aInt = item as? Int {
                return .int(aInt)
            } else if let str = item as? String {
                return .string(str)
            } else if let arr = item as? [Any] {
                return .init(arr)
            } else if let dict = item as? [String: Any] {
                return .init(dict)
            }
            return nil
        }
        self = .dictionary(dict)
    }
}

extension JSON {
    var intValue: Int? {
        if case .int(let aInt) = self {
            return aInt
        }
        return nil
    }
    
    var stringValue: String? {
        if case .string(let str) = self {
            return str
        }
        return nil
    }
    
    var arrayValue: [JSON]? {
        if case .array(let arr) = self {
            return arr
        }
        return nil
    }
    
    var dictionaryValue: Dictionary<String, JSON>? {
        if case .dictionary(let dict) = self {
            return dict
        }
        return nil
    }
    
    subscript(index: Int) -> JSON? {
        if case .array(let arr) = self {
            return index < arr.count ? arr[index] : nil
        }
        return nil
    }
    
    subscript(dynamicMember key: String) -> JSON? {
        if case .dictionary(let dict) = self {
            return dict[key]
        }
        return nil
    }
}

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
    print("name: ", name)
    let city = json[0]?.address?.city?.stringValue
    print("city: ", city)
}
