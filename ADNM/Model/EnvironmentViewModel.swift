//
//  EnvironmentViewModel.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/24.
//

import Foundation

class EnvironmentViewModel: ObservableObject {
  // 是否登陆
  @Published var isLoggined: Bool = false
  // 搜索关键字
  @Published var searchText: String = ""
  
  @Published var userProfile: UserProfile?
  
  @Published var navigationModel: NavigationModel = NavigationModel()
  
  @Published var showLogginSheet: Bool = false
}
