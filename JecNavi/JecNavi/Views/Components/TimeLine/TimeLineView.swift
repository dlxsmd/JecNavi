//
//  TimeLineView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/25.
//

import SwiftUI
import TipKit

struct TimeLineView: View {
    @ObservedObject var Authentication = AuthenticationManager()
    @ObservedObject var model = timeLineModel()
    @State var inputText = ""
    @State var isPostView = false
    @State var isShowTip = false
    var body: some View {
        NavigationStack{
            ZStack(alignment:.leading){
                HeaderView()
                Button(action: {
                    isShowTip = true
                }, label: {
                    Image(systemName: "questionmark.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.green)
                        .clipShape(Circle())
                        .padding(.leading,20)
                })
            }
            ZStack(alignment: .bottom){
                ScrollView{
                    LazyVStack(alignment: .leading){
                        ForEach(model.posts) { timeline in
                            VStack(alignment: .leading) {
                                Text(timeline.post)
                                    .textSelection(.enabled)
                                    .font(.headline)
                                Spacer(minLength: 20)
                                HStack {
                                    Spacer()
                                    Text(timeline.createdAt, formatter: DateFormatter.mediumDate)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.horizontal,50)
                            .padding(.vertical,20)
                            Divider()
                        }
                    }
                }
                .onAppear {
                    model.fetchPosts()
                }
                if Authentication.isSignIn{
                    Button(action: {
                        isPostView.toggle()
                    }, label: {
                        HStack{
                            Spacer()
                            ZStack {
                                Circle().foregroundColor(.green)
                                    .frame(width: 60, height: 60)
                                    .shadow(radius: 5)
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.white)
                                    .scaleEffect(2)
                            }
                        }
                        .padding()
                        .padding(.bottom, 70)
                    })
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    
                }
            }

        }
            .sheet(isPresented: $isPostView, content: {
                PostView(isPostView:$isPostView ,addPost: { post in
                    model.addPost(post: post)
                })
            })
            .sheet(isPresented: $isShowTip, content: {
                TimeLineTerms()
                    .presentationDetents([.fraction(0.7)])
            })
    }
}

#Preview {
    TimeLineView()
}
