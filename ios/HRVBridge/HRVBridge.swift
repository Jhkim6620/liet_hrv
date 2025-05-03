//
//  HRVBridge.swift
//  Liet
//
//  Created by 김종혁 on 5/3/25.
//

import Foundation
import React

@objc(HRVBridge)
class HRVBridge: NSObject {
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }

  @objc
  func getLatestHRV(_ resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) {
    if let hrv = HRVManager.shared.latestHRV {
      resolve(hrv)
    } else {
      reject("no_data", "HRV 데이터 없음", nil)
    }
  }
}
