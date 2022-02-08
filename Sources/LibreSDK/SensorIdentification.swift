//
//  SensorIdentification.swift
//  LibreSDK
//
//  Created by Julian Groen on 07/02/2022.
//

import Foundation


public class SensorIdentification {
    
    private enum Version: String, CustomStringConvertible {
        case a = "a"
        
        var description: String { self.rawValue }
    }
    
    private enum Regions: String, CustomStringConvertible {
        case a = "a"
        
        var description: String { self.rawValue }
    }
    
    public init(packet: SensorDataPacket) { }
}
