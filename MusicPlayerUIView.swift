//
//  MusicPlayerUIView.swift
//  What's Song?
//
//  Created by おくとみしょうた on 2023/07/29.
//

import SwiftUI
import AVFoundation

struct MusicPlayerView: View {
    let audioPlayer: AVAudioPlayer
    
    var body: some View {
        Button(action: {
            audioPlayer.play()
        }) {
            Text("Play Music")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
                .frame(width: 200)
                .background(Color.green)
                .cornerRadius(10)
        }
    }
}

struct MusicPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        // この部分に音楽ファイルをロードしてaudioPlayerを初期化します
        guard let url = Bundle.main.url(forResource: "クラリネット吹きの休日BGM", withExtension: "mp3") else {
            fatalError("音楽ファイルが見つかりません")
        }
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            return MusicPlayerView(audioPlayer: audioPlayer)
        } catch {
            fatalError("音楽ファイルの再生に失敗しました")
        }
    }
}
