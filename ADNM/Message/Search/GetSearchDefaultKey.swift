//
//  GetSearchDefaultKey.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/21.
//

import Foundation

struct GetSearchDefaultKeyResponse: Codable {
  var code: Int
  var message: String?
  var data: GetSearchDefaultKeyResponseData
}

struct GetSearchDefaultKeyResponseData: Codable {
  var showKeyword: String
  var realkeyword: String
  var searchType: Int
  var action: Int
}





func getSearchDefaultKey() async throws -> String {
  do {
    let timeStamp = NSDate().timeStamp
    
    guard let getSearchDefaultKeyUrl = URL(string: String(format: "\(baseURL)/search/default?timestamp=\(timeStamp)")) else { fatalError("Error URL") }
    
    let (data, response) = try await URLSession.shared.data(from: getSearchDefaultKeyUrl)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
      fatalError("Error while fetching data")
    }
    
    let searchDefaultKeyResponseData = try JSONDecoder().decode(GetSearchDefaultKeyResponse.self, from: data)
    let defaultSearchKey = searchDefaultKeyResponseData.data.showKeyword
    
    return defaultSearchKey
    
  } catch {
    throw error
  }
}
