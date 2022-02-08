import XCTest
@testable import LibreSDK

final class LibreSDKTests: XCTestCase {
    
    func testExample() throws {
//        let path = Bundle(for: LibreSDKTests.self).path(forResource: "libre_one_01", ofType: "txt")!
//        dump(try String(contentsOf: URL(fileURLWithPath: path)))
        
        let rawSensorContents = "815a101c03000000000000000000000000000000000000007fe30a10c205c8fc1880b405c81c1980a705c83819809a05c85419808c05c86819807905c87419806b05c88019806205c88c19805905c89019804e05c8941980a306884658008406c88418806306c8b818801606c8c41880ee05c8d41880d905c8ec18801a06c8e856003906c8005700a306c89c56000407c8b056006307c8fc5600e307c82057006b08c83017800209c8f056004109c8b817801409c8f017805409c84857009a09c82c57001e09c83456006e08c8c855003507c8681880dd05c8ec1880d804c82c5700df04c8b45600eb04c8645600e604c8141780ea04c8e817802605c82818801e05c8881880e704c80c1980d104c8681780c204c87457002005c8cc56004b05c84857000c05c83058000205c85018806505c8d456002d06c8d01680bb400000faca0001cd09d750140796805a00eda60ea61ac804799866"
        let sensorContents = Data(hexadecimal: rawSensorContents)!
        print(sensorContents[320..<344])
    }
}

extension Data {
    init?(hexadecimal: String) {
        self.init(capacity: hexadecimal.utf16.count / 2)
 
        // Convert 0 ... 9, a ... f, A ...F to their decimal value,
        // return nil for all other input characters
        func decodeNibble(u: UInt16) -> UInt8? {
            switch u {
            case 0x30 ... 0x39:  // '0'-'9'
                return UInt8(u - 0x30)
            case 0x41 ... 0x46:  // 'A'-'F'
                return UInt8(u - 0x41 + 10)  // 10 since 'A' is 10, not 0
            case 0x61 ... 0x66:  // 'a'-'f'
                return UInt8(u - 0x61 + 10)  // 10 since 'a' is 10, not 0
            default:
                return nil
            }
        }

        var even = true
        var byte: UInt8 = 0
        for c in hexadecimal.utf16 {
            guard let val = decodeNibble(u: c) else { return nil }
            if even {
                byte = val << 4
            } else {
                byte += val
                self.append(byte)
            }
            even = !even
        }
        guard even else { return nil }
    }
}
