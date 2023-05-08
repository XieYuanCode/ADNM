//
//  OnlineMusic.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/17.
//

import SwiftUI

struct OnlineMusic: View {
  @EnvironmentObject private var viewModel: EnvironmentViewModel
  
  
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      VStack(spacing: 10) {
        BannersView()
      }
      .padding()
      
    }
  }
}
