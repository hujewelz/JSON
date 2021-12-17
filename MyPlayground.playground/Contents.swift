import Foundation

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
