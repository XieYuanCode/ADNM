//
//  Logout.swift
//  ADNM
//
//  Created by 谢渊 on 2023/5/5.
//

import Foundation

struct LogoutResponse: Codable {
  var code: Int
}

func logout() async throws -> Void {
  do {
    let timeStamp = NSDate().timeStamp
    
    guard let logoutUrl = URL(string: String(format: "\(baseURL)/logout?timestamp=\(timeStamp)")) else { fatalError("Error URL") }
    
    let (data, response) = try await URLSession.shared.data(from: logoutUrl)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
      fatalError("Error while fetching data")
    }
    
    let url = URL(string: baseURL)!
    let cstorage = HTTPCookieStorage.shared
    
    if let cookies = cstorage.cookies(for: url) {
      for cookie:HTTPCookie in cookies {
        cstorage.deleteCookie(cookie)
      }
    }
    if(cstorage.cookies(for: url)?.count == 0) {
      debugPrint("Cookies清除成功")
    }
    
    let logoutResponse = try JSONDecoder().decode(LogoutResponse.self, from: data)
    
    if(logoutResponse.code != 200) {
      debugPrint("登出失败")
    }
  }
}
