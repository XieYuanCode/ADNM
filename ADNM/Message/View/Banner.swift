//
//  Banner.swift
//  ADNM
//
//  Created by 谢渊 on 2023/5/8.
//

import Foundation

struct Banner : Codable {
  var imageUrl: String?
  var typeTitle: String?
  var url: String?
  /// 3000 网页， 10 专辑， 1 歌曲
  var targetType: Int?
  var targetId: Int?
}

struct GetBannerResponse: Codable {
  var code: Int
  var banners: [Banner]?
}

func getBanners() async throws -> [Banner] {
  do {
    let timeStamp = NSDate().timeStamp
    
    guard let getBannersUrl = URL(string: String(format: "\(baseURL)/banner?timestamp=\(timeStamp)&type=0")) else { fatalError("Error URL") }
    
    let (data, response) = try await URLSession.shared.data(from: getBannersUrl)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
      fatalError("Error while fetching data")
    }
    
    let bannerResponse = try JSONDecoder().decode(GetBannerResponse.self, from: data)
    
    var banners: [Banner] = []
    
    bannerResponse.banners?.forEach({ banner in
      banners.append(Banner(
        imageUrl: banner.imageUrl?.replacingOccurrences(of: "http://", with: "https://"),
        typeTitle: banner.typeTitle,
        url: banner.url,
        targetType: banner.targetType,
        targetId: banner.targetId
      ))
    })
    
    return banners
  } catch {
    throw error
  }
}
