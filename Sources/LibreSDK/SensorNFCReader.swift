//
//  SensorNFCReader.swift
//  
//
//  Created by Julian Groen on 06/02/2022.
//

import Foundation
#if canImport(CoreNFC)
import CoreNFC

@available(iOS 13.0, *)
class SensorNFCReader: NSObject, NFCTagReaderSessionDelegate {
    
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        
    }
}
#endif
