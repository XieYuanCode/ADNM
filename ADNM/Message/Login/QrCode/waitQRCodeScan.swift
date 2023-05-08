//
//  waitQRCodeScan.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/21.
//

import Foundation

enum QrcodeAuthStatus: String {
  case waiting = "waiting", expiredOrinexistent, authorizing, success
}

struct QRCodeCheckStatusResponse: Codable {
  var message: String
  var code: Int
  var cookie: String?
  var avatarUrl: String?
  var nickname: String?
}

struct QRCodeScaner {
  var avatarUrl: String?
  var nickname: String?
}

func getQRCodeAuthStatus(key: String)async throws -> (QrcodeAuthStatus, QRCodeScaner?) {
  do {
    let timeStamp = NSDate().timeStamp
    
    guard let getQrCodeCheckedUrl = URL(string: String(format: "\(baseURL)/login/qr/check?key=\(key)&timestamp=\(timeStamp)")) else { fatalError("Error URL") }
    
    let (data, response) = try await URLSession.shared.data(from: getQrCodeCheckedUrl)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
      fatalError("Error while fetching data")
    }
    
    let qrCodeCheckStatusResponse = try JSONDecoder().decode(QRCodeCheckStatusResponse.self, from: data)
    
    if(qrCodeCheckStatusResponse.code == 800) {
      return (QrcodeAuthStatus.expiredOrinexistent, nil)
    } else if (qrCodeCheckStatusResponse.code == 802) {
      return (QrcodeAuthStatus.authorizing, QRCodeScaner(avatarUrl: qrCodeCheckStatusResponse.avatarUrl, nickname: qrCodeCheckStatusResponse.nickname))
    } else if (qrCodeCheckStatusResponse.code == 803) {
      return (QrcodeAuthStatus.success, nil)
    } else {
      return (QrcodeAuthStatus.waiting, nil)
    }
  }
}
