//
//  SensorDataPacket.swift
//  LibreSDK
//
//  Created by Julian Groen on 06/02/2022.
//

import Foundation


// FUTURE: parseFRAMData() function to parse raw FRAM data from transmitter for example
public func parse_a() -> SensorDataPacket { return SensorDataPacket() }

// FUTURE: parseBLEData() function to parse raw BLE data from native connection with sensor
public func parse_b() -> SensorDataPacket { return SensorDataPacket() }

public class SensorDataPacket {
    
}

public protocol SensorDelegate {
    
}
