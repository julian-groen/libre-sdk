//
//  SensorBLEModule.swift
//  LibreSDK
//
//  Created by Julian Groen on 27/02/2022.
//

import Foundation
import os.log
import CoreBluetooth

public class SensorBLEModule: NSObject, CBCentralManagerDelegate {
    
    private let logger = Logger(subsystem: "com.libre-sdk", category: "SensorBLEModule")
    
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        logger.info("\(#function): \(String(describing: central))")
    }
}
