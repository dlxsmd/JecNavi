//
//  IntroSigninview.swift
//  JecNavi
//
//  Created by yuki on 2024/07/04.
//

import SwiftUI

struct IntroSigninView: View {
    @ObservedObject var Authentication = AuthenticationManager()
    @AppStorage("isInit") var isInit = true
    @State private var isSignin = false
    @Binding var page:Int
    var body: some View {
        
        VStack{
            Image("applogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
        
                .padding()
            
            VStack(alignment:.leading){
                Text("For Students,")
                Text("From Student.")
            }.padding()

            
            
            
            // Sign in with Google
            Button(action: {
                isSignin = true
            }, label: {
                Text("Sign in with Google")
                    .frame(width: 170)
                    .foregroundColor(.white)
                    .padding()
                    .background(.green)
                    .clipShape(Capsule())
            })
                
            
            
            //Sign in as guest
            Button(action: {
                isInit = false
                page = 1
            }, label: {
                Text("Sign in as guest")
                    .frame(width: 170)
                    .foregroundColor(.green)
                    .padding()
                    .background(.white)
                    .clipShape(Capsule())
                    .overlay{
                        Capsule()
                            .stroke(.green,lineWidth: 1)
                    }
            })
        }.sheet(isPresented: $isSignin) {
            SignInView()
        }
        .onChange(of:Authentication.isSignIn){
            isInit = false
            page = 1
        }

    }
}

#Preview {
    IntroSigninView(page: .constant(1))
}
