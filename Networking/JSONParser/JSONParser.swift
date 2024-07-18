//
//  JSONParser.swift
//  Networking
//
//  Created by Janbaz Ali on 02/11/2023.
//
protocol JSONDecoding {
    func encode<T: Encodable>(value: T) throws -> Data?
    func decode<T: Decodable>(value: Data) throws -> T
}

final public class JSONParser {
    public class func encode<T: Encodable>(value: T) throws -> Data? {
        let jsonEncoder = JSONEncoder()
        return try jsonEncoder.encode(value)
    }

    public class func decode<T: Decodable>(value: Data) throws -> T {
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(T.self, from: value)
    }
}
