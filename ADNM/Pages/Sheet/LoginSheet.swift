//
//  LoginSheet.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/14.
//

import SwiftUI
import Kingfisher

enum LoginSheetViewType: String {
  case qrCode = "qrCode", other
}
enum LoginType: String {
  case password = "password", cerificationCode
  
}

struct LoginSheet: View {
  @State private var qrCodeImgBase64 = ""
  @State private var qrCodeImgKey = ""
  @State private var loginSheetViewType = LoginSheetViewType.qrCode
  @State private var loginType = LoginType.password
  @State private var phone: String = ""
  @State private var password: String = ""
  @State private var cerificationCode: String = ""
  @State private var agreePolicy: Bool = false
  @State private var supportPhoneLogin: Bool = false
  @State private var isQrCodeScaned: Bool = false
  @State private var qrCodeScanerNickname: String = ""
  @State private var qrCodeScanerAvatarUrl: String = ""
  @State private var showLoginSuccessToast: Bool = false
  
  @EnvironmentObject private var viewModel: EnvironmentViewModel
  
  
  var body: some View {
    Group {
      if(loginSheetViewType == LoginSheetViewType.qrCode) {
        VStack(alignment: .center, spacing: 10) {
          Label("扫码登陆", systemImage: "qrcode.viewfinder")
            .font(.largeTitle)
          
          if(!isQrCodeScaned) {
            Image(base64Str: qrCodeImgBase64)
              .frame(width: 200, height: 200)
          } else {
            VStack(alignment: .center) {
              Spacer()
              KFImage(URL(string: qrCodeScanerAvatarUrl)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
              Spacer()
              Text("请在手机上确认登陆")
                .font(.title3)
              Spacer()
            }
          }
          if (!isQrCodeScaned) {
            HStack(alignment: .center, spacing: 0) {
              Text("使用")
              Link("网易云音乐app", destination: URL(string: "https://music.163.com/#/download")!)
                .onHover(perform: { hovering in
                  hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                })
              Text("扫码登陆")
            }
          }
          Spacer()
          Text("选择其他登陆模式 >")
            .font(.callout)
            .foregroundColor(.gray)
            .onHover(perform: { hovering in
              hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
            })
            .onTapGesture {
              loginSheetViewType = LoginSheetViewType.other
            }
            .help("暂时无法使用其他登陆方式")
        }
        .padding()
        .toast(isPresenting: $showLoginSuccessToast, text: "登陆成功")
        .task {
          do {
            let (qrcode, key) = try await getLoginQRCode()
            qrCodeImgBase64 = qrcode
            qrCodeImgKey = key
            
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
              Task {
                let (status, scaner) = try await getQRCodeAuthStatus(key: qrCodeImgKey)
                
                if(status == QrcodeAuthStatus.expiredOrinexistent) {
                  let (qrcode, key) = try await getLoginQRCode()
                  qrCodeImgBase64 = qrcode
                  qrCodeImgKey = key
                } else if (status == QrcodeAuthStatus.authorizing) {
                  isQrCodeScaned = true
                  qrCodeScanerNickname = (scaner?.nickname)!
                  qrCodeScanerAvatarUrl = (scaner?.avatarUrl)!
                } else if (status == QrcodeAuthStatus.success) {
                  let (isLogined, userProfile) = try await checkIsLogined()
                  viewModel.isLoggined = isLogined
                  viewModel.userProfile = userProfile
                  timer.invalidate()
                  showLoginSuccessToast = true
                  viewModel.showLogginSheet = false
                }
              }
            }
          } catch {
            qrCodeImgBase64 = ""
          }
        }
      } else {
        VStack(alignment: .center, spacing: 10) {
          Label("手机登陆", systemImage: "candybarphone")
            .font(.largeTitle)
          Spacer()
          Picker("登陆方式", selection: $loginType) {
            Text("账号密码").tag(LoginType.password)
            Text("验证码").tag(LoginType.cerificationCode)
          }
          .pickerStyle(.segmented)
          HStack {
            TextField("手机号码", text: $phone)
              .textFieldStyle(.roundedBorder)
          }
          
          Group {
            if(loginType == LoginType.cerificationCode) {
              HStack {
                TextField("验证码", text: $cerificationCode)
                Button("发送验证码", action: {})
              }
            } else {
              TextField("密码", text: $password)
            }
          }
          .textFieldStyle(.roundedBorder)
          HStack(alignment: .center) {
            Button(action: {}) {
              Text("注册")
                .padding()
            }
            .buttonStyle(.link)
            .onHover(perform: { hovering in
              hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
            })
            
            Button(action: {}) {
              Text("登陆")
                .padding()
            }
            .buttonStyle(.borderedProminent)
            .disabled(!supportPhoneLogin)
            .help("暂不支持手机登陆，请使用二维码登陆")
          }
          if (!supportPhoneLogin) {
            Label("暂不支持手机登陆，请使用二维码登陆", systemImage: "exclamationmark.triangle")
              .font(.callout)
              .foregroundStyle(.primary, .yellow)
          }
          
          Spacer()
          HStack(spacing: 0) {
            Toggle("同意", isOn: $agreePolicy)
              .toggleStyle(.checkbox)
            Link("《服务条款》", destination: URL(string: "https://st.music.163.com/official-terms/service")!)
              .onHover(perform: { hovering in
                hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
              })
            Link("《隐私政策》", destination: URL(string: "https://st.music.163.com/official-terms/privacy")!)
              .onHover(perform: { hovering in
                hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
              })
            Link("《儿童隐私政策》", destination: URL(string: "https://st.music.163.com/official-terms/children")!)
              .onHover(perform: { hovering in
                hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
              })
          }
          .font(.system(size: 9))
          Text("扫码登陆 >")
            .font(.callout)
            .foregroundColor(.gray)
            .onHover(perform: { hovering in
              hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
            })
            .onTapGesture {
              loginSheetViewType = LoginSheetViewType.qrCode
            }
        }
        .padding()
      }
    }
  }
}
