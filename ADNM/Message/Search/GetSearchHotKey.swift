//
//  GetSearchHotKey.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/21.
//

import Foundation

struct GetSearchHotKeysResponse: Codable {
  var code: Int
  var data: [GetSearchHotKeysResponseData]
}

struct GetSearchHotKeysResponseData: Codable {
  var searchWord: String?
  var score: Int?
  var content: String?
  var url: String?
  var iconUrl: String?
  var iconType: Int?
}

struct GetSearchHotKeysResponseDataIdentifiable: Codable, Identifiable {
  var sourceData: GetSearchHotKeysResponseData
  
  var id: UUID = UUID()
}

func getSearchHotKeys() async throws -> [GetSearchHotKeysResponseDataIdentifiable] {
  do {
    let timeStamp = NSDate().timeStamp
    
    guard let getSearchHotKeysUrl = URL(string: String(format: "\(baseURL)/search/hot/detail?timestamp=\(timeStamp)")) else { fatalError("Error URL") }
    
    let (data, response) = try await URLSession.shared.data(from: getSearchHotKeysUrl)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
      fatalError("Error while fetching data")
    }
    
    let getSearchHotKeys = try JSONDecoder().decode(GetSearchHotKeysResponse.self, from: data)
    
    var result: [GetSearchHotKeysResponseDataIdentifiable] = []
    
    getSearchHotKeys.data.forEach {hotKey in
      result.append(GetSearchHotKeysResponseDataIdentifiable(sourceData: hotKey))
    }
    
    return result
    
  } catch {
    debugPrint(error)
    throw error
  }
}
