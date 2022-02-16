//
//  SensorNFCReader.swift
//  LibreSDK
//
//  Created by Julian Groen on 06/02/2022.
//

import Foundation
import os.log
import CoreNFC

import SwiftUI


// FUTURE: initialize reader session to connect of retrieve data from sensor via NFC
@available(iOS 13.0, *)
public class SensorNFCReader: NSObject, NFCTagReaderSessionDelegate, ObservableObject {
    
    @Published public var response: String?

    
    private let logger = Logger(subsystem: "com.libre-sdk", category: "SensorNFCReader")
      
    private var session: NFCTagReaderSession?
    
    public func read() {
        guard NFCTagReaderSession.readingAvailable else { return }
        session = NFCTagReaderSession(pollingOption: [.iso15693], delegate: self, queue: .main)
        session?.alertMessage = "Hold the top edge of your iPhone close to the sensor."
        session?.begin()
    }
    
    public func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        logger.info("\(#function): \(String(describing: session))")
    }
    
    public func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        logger.info("\(#function): \(String(describing: session))")
    }
    
    public func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        logger.info("\(#function): \(String(describing: session))")
        guard let sensor = tags.first, case let .iso15693(tag) = sensor else { return }
        session.connect(to: sensor) { error in self.process(sensor: tag) }
    }
    
    private func process(sensor: NFCISO15693Tag) {
        let uid = Data(sensor.identifier.reversed())
        response = uid.string()
        
        sensor.customCommand(requestFlags: .highDataRate, customCommandCode: info, customRequestParameters: Data()) { data, error in
            self.response = data.string()
            print(SensorIdentification(uid: uid, info: data))
        }
        
        // session?.invalidate()
    }
}

let info: Int = 0xA1

fileprivate extension NFCISO15693Tag {
        
    func execute(command: Int) {
        customCommand(requestFlags: .highDataRate, customCommandCode: command, customRequestParameters: Data()) { data, error in
            // SensorNFCReader.response = data.string()
        }
    }
}

public extension Data {
    func string() -> String {
        return map { String(format: "%02X", $0) }.joined(separator: "")
    }
}
