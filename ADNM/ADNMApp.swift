//
//  ADNMApp.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/7.
//

import SwiftUI

@main
struct ADNMApp: App {
  @StateObject var viewModel: EnvironmentViewModel = EnvironmentViewModel()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
#if os(macOS)
        .task {
          do {
            let (isLogined, userProfile) = try await checkIsLogined()
            viewModel.isLoggined = isLogined
            viewModel.userProfile = userProfile
          } catch {
            
          }
        }
        .environmentObject(viewModel)
#endif
    }
    Settings {
      SettingView()
    }
  }
}
