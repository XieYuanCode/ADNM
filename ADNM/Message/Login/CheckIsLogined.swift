//
//  CheckIsLogined.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/28.
//

import Foundation

struct CheckIsLoginedResponse: Codable {
  var data: CheckIsLoginedResponseData
}

struct CheckIsLoginedResponseDataAccount: Codable {
  
}

struct CheckIsLoginedResponseDataProfile: Codable {
  var userId: Int?
  var userType: Int?
  var nickname: String?
  var avatarUrl: String?
  var backgroundUrl: String?
  var signature: String?
  var createTime: Int?
  var birthday: Int?
  var userName: String?
  var shortUserName: String?
  var gender: Int?
}

struct CheckIsLoginedResponseData: Codable {
  var code: Int
  var account: CheckIsLoginedResponseDataAccount
  var profile: CheckIsLoginedResponseDataProfile?
}

func checkIsLogined() async throws -> (Bool, UserProfile?) {
  do {
    let timeStamp = NSDate().timeStamp
    
    guard let checkIsLoginedUrl = URL(string: String(format: "\(baseURL)/login/status?timestamp=\(timeStamp)"))  else { fatalError("Error URL") }
    
    let (data, response) = try await URLSession.shared.data(from: checkIsLoginedUrl)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
      fatalError("Error while fetching data")
    }
    
    let checkIsLoginedResponse = try JSONDecoder().decode(CheckIsLoginedResponse.self, from: data)
    
    if(checkIsLoginedResponse.data.profile == nil) {
      return (false, nil)
    } else {
      let userProfile = UserProfile(
        userId: checkIsLoginedResponse.data.profile?.userId,
        userType: checkIsLoginedResponse.data.profile?.userType,
        nickname:checkIsLoginedResponse.data.profile?.nickname,
        avatarUrl: checkIsLoginedResponse.data.profile?.avatarUrl?.replacingOccurrences(of: "http://", with: "https://"),
        backgroundUrl: checkIsLoginedResponse.data.profile?.backgroundUrl?.replacingOccurrences(of: "http://", with: "https://"),
        signature: checkIsLoginedResponse.data.profile?.signature,
        createTime: checkIsLoginedResponse.data.profile?.createTime,
        birthday: checkIsLoginedResponse.data.profile?.birthday,
        userName: checkIsLoginedResponse.data.profile?.userName,
        shortUserName: checkIsLoginedResponse.data.profile?.shortUserName,
        gender: checkIsLoginedResponse.data.profile?.gender
      )
      return (true, userProfile)
    }
  } catch {
    throw error
  }
}
