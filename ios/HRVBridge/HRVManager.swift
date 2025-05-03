//
//  HRVManager.swift
//  Liet
//
//  Created by 김종혁 on 5/3/25.
//

import Foundation
import WatchConnectivity

@objcMembers
@objc(HRVManager)
class HRVManager: NSObject, WCSessionDelegate {
    
    static let shared = HRVManager() // Singleton instance

    var latestHRV: Double? = nil

    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    // Watch에서 메시지 수신
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let hrv = message["hrv"] as? Double {
            latestHRV = hrv
            print("수신된 HRV 값: \(hrv)")
        }
    }

    // WCSession 필수 델리게이트
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("WCSession 활성화 완료")
    }

    // JS에서 사용할 수 있는 메서드
    func getHRVValue() -> String {
        return "\(latestHRV ?? -1.0)"
    }
}
