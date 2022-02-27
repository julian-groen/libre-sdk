//
//  SensorIdentification.swift
//  LibreSDK
//
//  Created by Julian Groen on 07/02/2022.
//

import Foundation

public class SensorIdentification: CustomStringConvertible {
    
    public var serial: String? = nil
    
    public var version: Version = .unknown

    public var region: Region = .unknown
    
    public var description: String {
        return "SensorIdentification(\(String(describing: serial)), \(version), \(region))"
    }
    
    public init(uid: Data, info: Data) {
        switch info[0] {
            case 0xDF: self.version = .a
            case 0xA2: self.version = .a
            case 0x9D: self.version = .b
            // case 0x9D: self.version = .c
            // case 0xE5: self.version = .d
            case 0x70: self.version = .e
            case 0xE5: self.version = .f
            default:   self.version = .unknown
        }
        switch info[3] {
            case 0x08: self.region = .eastern
            case 0x04: self.region = .oceania
            case 0x02: self.region = .american
            case 0x01: self.region = .european
            default:   self.region = .unknown
        }
        self.serial = serial(uid, info)
    }
    
    public func serial(_ uid: Data, _ info: Data) -> String? {
        guard uid.count == 8 else { return nil }
        let bytes = Array(uid.reversed().suffix(6))
        let table = "0123456789ACDEFGHJKLMNPQRTUVWXYZ".map { String($0) }
        var serialnumber = [UInt8]()
        serialnumber.append(bytes[0] >> 3)
        serialnumber.append(bytes[0] << 2 + bytes[1] >> 6)
        serialnumber.append(bytes[1] >> 1)
        serialnumber.append(bytes[1] << 4 + bytes[2] >> 4)
        serialnumber.append(bytes[2] << 1 + bytes[3] >> 7)
        serialnumber.append(bytes[3] >> 2)
        serialnumber.append(bytes[3] << 3 + bytes[4] >> 5)
        serialnumber.append(bytes[4])
        serialnumber.append(bytes[5] >> 3)
        serialnumber.append(bytes[5] << 2)
        return serialnumber.reduce("\(Int(info[2] >> 4))", { $0 + table[Int(0x1F & $1)] })
    }
    
    public enum Version: String, CustomStringConvertible {
        case a          = "FreeStyle Libre 1"
        case b          = "FreeStyle Libre 2"
        case c          = "FreeStyle Libre 3"
        case d          = "FreeStyle Libre Sense"
        case e          = "FreeStyle Libre Pro/H"
        case f          = "FreeStyle Libre 14day"
        case unknown    = "Unknown"
      
        public var description: String { self.rawValue }
    }
    
    public enum Region: String, CustomStringConvertible {
        case european   = "European"
        case american   = "United States"
        case oceania    = "Oceania"
        case eastern    = "Eastern"
        case unknown    = "Unknown"
        
        public var description: String { self.rawValue }
    }
}
