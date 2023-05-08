//
//  SingerView.swift
//  ADNM
//
//  Created by 谢渊 on 2023/5/6.
//

import SwiftUI

struct SingerView: View {
  @EnvironmentObject var viewModel: EnvironmentViewModel
  
  
    var body: some View {
      VStack {
        Text("歌手id: \(viewModel.navigationModel.singerID!)")
      }
      .onAppear {
        viewModel.navigationModel.singerID = 1060132
      }
    }
}
