//
//  getLoginQRCode.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/21.
//

import Foundation

struct GetQRCodeUnikeyResponse:Codable {
  var code: Int
  var data: GetQRCodeUnikeyResponseData
}

struct GetQRCodeUnikeyResponseData:Codable {
  var code: Int
  var unikey: String
}

struct GetQRCodeResponse: Codable {
  var data: GetQRCodeResponseData
  var code: Int
}

struct GetQRCodeResponseData: Codable {
  var qrimg: String
  var qrurl: String
}


func getLoginQRCode() async throws -> (String, String) {
  do {
    let timeStamp = NSDate().timeStamp
    
    guard let getQrCodeKeyUrl = URL(string: String(format: "\(baseURL)/login/qr/key?timestamp=\(timeStamp)")) else { fatalError("Error URL") }
    
    let (data, response) = try await URLSession.shared.data(from: getQrCodeKeyUrl)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
      fatalError("Error while fetching data")
    }
    
    
    let qrCodeUnikeyResponseData = try JSONDecoder().decode(GetQRCodeUnikeyResponse.self, from: data)
    let unikey = qrCodeUnikeyResponseData.data.unikey
    
    guard let getQrCodeUrl = URL(string: String(format: "\(baseURL)/login/qr/create?timestamp=\(timeStamp)&key=\(unikey)&qrimg=true")) else { fatalError("Error URL") }
    
    let (data1, response1) = try await URLSession.shared.data(from: getQrCodeUrl)
    
    guard let httpResponse1 = response1 as? HTTPURLResponse,
          httpResponse1.statusCode == 200 else {
      fatalError("Error while fetching data")
    }
    
    let qrCodeResponseData = try JSONDecoder().decode(GetQRCodeResponse.self, from: data1)
    let imgBase64 = qrCodeResponseData.data.qrimg
    
    return (imgBase64.replacingOccurrences(of: "data:image/png;base64,", with: ""), unikey)
    
  } catch {
    throw error
  }
}
