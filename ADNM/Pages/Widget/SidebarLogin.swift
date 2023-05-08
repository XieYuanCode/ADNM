//
//  SidebarLogin.swift
//  ADNM
//
//  Created by 谢渊 on 2023/5/6.
//

import SwiftUI
import Kingfisher

struct SidebarLogin: View {
  @EnvironmentObject var viewModel: EnvironmentViewModel
  
    var body: some View {
      Group {
        if (viewModel.isLoggined == true) {
          HStack {
            Text("已登陆，欢迎\((viewModel.userProfile?.nickname)!)")
            KFImage(URL(string: (viewModel.userProfile?.avatarUrl)!)!)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 50, height: 50)
              .clipShape(Circle())
          }
        } else {
          Button(action: {
            viewModel.showLogginSheet.toggle()
          }) {
            Label("点击登陆", systemImage: "person.circle")
              .font(.title)
              .imageScale(.large)
          }
          .buttonStyle(.borderless)
          .onHover(perform: cursorToPointingWhenHovering)
          .padding(.vertical)
          .sheet(isPresented: $viewModel.showLogginSheet) {
            LoginSheet()
              .frame(width: 270, height: 330)
          }
        }
      }
    }
}

