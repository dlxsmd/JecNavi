//
//  songView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/30.
//

import SwiftUI
import AVFoundation

struct SongView: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false
    @State private var currentTime: TimeInterval = 0
    @State private var duration: TimeInterval = 0
    
    private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
                Text(
                    """
                    大きな夢を胸に抱き
                    我らが学ぶ誇らかに
                    この瞳　この指先が
                    月と地球を結ぶのだ
                    ああ　エレクトロンの花開く
                    日本電子専門学校

                    飛び交う電波大宇宙
                    世紀の火花胸に散る
                    この技術　この情熱が
                    明日の文化を創るのだ
                    ああ　エレクトロンの花開く
                    日本電子専門学校

                    理想は高くたくましく
                    我等は集うすこやかに
                    この若さ　この友情が
                    世界平和を築くのだ
                    ああ　エレクトロンの花開く
                    日本電子専門学校
                    """
                )
                .font(.title2)
                .padding()
            
            // Music Player Controls
            VStack {
                HStack {
                    Button(action: {
                        if isPlaying {
                            audioPlayer?.pause()
                        } else {
                            audioPlayer?.play()
                        }
                        isPlaying.toggle()
                    }, label: {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.green)
                            .clipShape(Circle())
                    })
                    
                    // Seek bar
                    Slider(value: $currentTime, in: 0...duration, onEditingChanged: { isEditing in
                        if !isEditing {
                            audioPlayer?.currentTime = currentTime
                        }
                    })
                    .accentColor(.green)
                }
                .padding()
                
                HStack {
                    Text(formatTime(currentTime))
                    Spacer()
                    Text("-\(formatTime(duration-currentTime))")
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            prepareAudioPlayer()
        }
        .onReceive(timer) { _ in
            guard let player = audioPlayer else { return }
            currentTime = player.currentTime
        }
    }
    
    private func prepareAudioPlayer() {
        guard let path = Bundle.main.path(forResource: "校歌", ofType: "mp3") else {
            print("Audio file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.prepareToPlay()
            duration = audioPlayer?.duration ?? 0
        } catch {
            print("Error initializing AVAudioPlayer: \(error.localizedDescription)")
        }
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

#Preview{
    SongView()
}
