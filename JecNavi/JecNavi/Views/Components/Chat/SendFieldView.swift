//
//  SendFieldView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/18.
//

import SwiftUI

struct SendFieldView: View {
    @State var inputMessage = ""
    var sendMessage: (String) -> Void
    var body: some View {
        ZStack(alignment:.bottomTrailing){
            TextField("Message Input", text: $inputMessage,axis: .vertical)
                .padding()
                .padding(.trailing,50)
                .background(Color(.systemGray6))
                .cornerRadius(30)
                .onSubmit(){
                    sendMessage(inputMessage)
                    inputMessage = ""
                }
    
            Button(action: {
                sendMessage(inputMessage)
                inputMessage = ""
            }, label: {
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
                    .padding(3)
            })
            .disabled(inputMessage.isEmpty)
            .buttonStyle(.borderedProminent)
            .clipShape(Capsule())
            .padding(.bottom,5)
            .padding(.trailing,5)
            
            
        }
    }
}

#Preview {
    SendFieldView(sendMessage: { message in
        print(message)
    })
}
