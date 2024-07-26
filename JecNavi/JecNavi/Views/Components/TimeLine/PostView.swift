//
//  PostView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/26.
//

import SwiftUI

struct PostView: View {
    @State private var isCancelAlert = false
    @State private var inputText = ""
    @Binding var isPostView: Bool
    var addPost: (String) -> Void
    @FocusState private var isFocus: Bool
    
    private var isInputValid: Bool {
        let trimmedText = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        let sanitizedText = replaceMultipleNewlines(with: trimmedText)
        return !sanitizedText.isEmpty &&
               sanitizedText.count >= 10 &&
               sanitizedText.count <= 200
    }
    
    private func replaceMultipleNewlines(with text: String) -> String {
        return text.replacingOccurrences(of: "\n{2,}", with: "\n", options: .regularExpression)
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    TextField("今日の出来事を共有しよう!", text: $inputText, axis: .vertical)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .focused($isFocus)
                    
                    Spacer()
                }
                Button(action: {
                    let trimmedText = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
                    let sanitizedText = replaceMultipleNewlines(with: trimmedText)
                    addPost(sanitizedText)
                    inputText = ""
                    isPostView = false
                }, label: {
                    Text("Post")
                        .foregroundColor(.white)
                        .padding(10)
                })
                .disabled(!isInputValid)
                .buttonStyle(.borderedProminent)
                .clipShape(Capsule())
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        if !inputText.isEmpty{
                            isCancelAlert = true
                        }else{
                            isPostView = false
                        }
                    }, label: {
                        Text("Cancel")
                    })
                }
            }
            .onAppear() {
                DispatchQueue.main.async {
                    isFocus = true
                }
            }
            .alert(isPresented: $isCancelAlert) {
                Alert(
                    title: Text("Cancel"),
                    message: Text("Are you sure you want to cancel?"),
                    primaryButton: .cancel(),
                    secondaryButton: .destructive(Text("OK"), action: {
                        isPostView = false
                    })
                )
            }
        }
    }
}
#Preview {
    PostView(isPostView: .constant(true), addPost: { post in
        print(post)
    })
}
