//
//  SensorNFCReader.swift
//  LibreSDK
//
//  Created by Julian Groen on 06/02/2022.
//

#if canImport(CoreNFC)
import Foundation
import CoreNFC

public func test_a() { }

@available(iOS 13.0, *)
class SensorNFCReader: NSObject, NFCTagReaderSessionDelegate {
    
    public func read() {
        guard NFCTagReaderSession.readingAvailable else { return }
        if let session = NFCTagReaderSession(pollingOption: [.iso15693], delegate: self, queue: .main) {
            session.alertMessage = "Hold the top edge of your iPhone close to the sensor."
            session.begin()
        }
    }
    
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        
    }
}
#endif
