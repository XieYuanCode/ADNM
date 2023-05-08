//
//  Banner.swift
//  ADNM
//
//  Created by 谢渊 on 2023/5/8.
//

import SwiftUI
import Kingfisher

struct BannersView: View {
  @State var banners: [Banner] = []
  @EnvironmentObject var viewModel: EnvironmentViewModel
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 10) {
        ForEach(banners, id: \.targetId) { banner in
          BannerView(banner: banner)
            .onTapGesture {
              if(banner.targetType != nil) {
                if( banner.targetType == 3000) {
                  debugPrint("打开网页:\(banner.url!)")
                } else if (banner.targetType == 10) {
                  viewModel.navigationModel.openAlbumView(albumID: banner.targetId!)
                } else if (banner.targetType == 1) {
                  viewModel.navigationModel.songID = banner.targetId!
                  viewModel.navigationModel.selectedSidebar  = .Song
                }
              }
            }
        }
      }
    }.task {
      do {
        banners = try await getBanners()
      } catch {
        debugPrint(error)
      }
    }
  }
}

struct BannerView: View {
  @State var banner: Banner
  
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      KFImage(URL(string: banner.imageUrl!)!)
        .resizable()
        .frame(width: 500, height: 200)
        .cornerRadius(10)
        .shadow(radius: 4)
        .scaledToFill()
        .onHover(perform: cursorToPointingWhenHovering)
      Text(banner.typeTitle ?? "")
        .padding()
        .background(.red)
        .foregroundColor(.white)
        .frame(width: 80, height: 20)
        .font(.caption)
        .cornerRadius(20)
    }
  }
}
