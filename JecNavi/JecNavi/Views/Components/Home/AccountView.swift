//
//  AccountView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/17.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var authenticationManager = AuthenticationManager()
    @State private var isShowLogin = false
    @State private var isConfirmLogout = false
    
    var body: some View {
        VStack {
            if authenticationManager.isSignIn {
                HStack{
                    if let photoURL = authenticationManager.userPhotoURL {
                        AsyncImage(url: photoURL) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                        } placeholder: {
                            ProgressView()
                                .frame(width: 70, height: 70)
                        }
                    } else {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                            .frame(width: 70, height: 70)
                    }
                    VStack(alignment:.leading){
                        Text("\(authenticationManager.userName)")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text(" \(authenticationManager.userEmail)")
                    }
                    Spacer()
                }

                Button("Sign Out") {
                    isConfirmLogout.toggle()
                }.buttonStyle(.borderedProminent)
            } else {
                HStack{
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                            .frame(width: 70, height: 70)
                        Text("Sign In")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                .onTapGesture {
                    isShowLogin.toggle()
                }
            }
        }
        .onAppear(){
            authenticationManager.startListening()
        }
        .onDisappear(){
            authenticationManager.stopListening()
        }
        .alert(isPresented: $isConfirmLogout){
            Alert(
                title: Text("Sign Out"),
                message: Text("Are you sure you want to sign out?"),
                primaryButton: .destructive(Text("Sign Out")) {
                    authenticationManager.signOut()
                },
                secondaryButton: .cancel(Text("Cancel"))
            )
        }
        .sheet(isPresented: $isShowLogin) {
            SignInView()
        }
    }
}


#Preview {
    AccountView()
}
