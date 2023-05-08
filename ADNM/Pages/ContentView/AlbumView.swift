//
//  AlbumView.swift
//  ADNM
//
//  Created by 谢渊 on 2023/5/8.
//

import SwiftUI

struct AlbumView: View {
  @EnvironmentObject var viewModel: EnvironmentViewModel
    var body: some View {
      Text("专辑ID:\((viewModel.navigationModel.albumID)!)")
    }
}
