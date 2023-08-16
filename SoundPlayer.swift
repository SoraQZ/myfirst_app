//
//  SoundPlayer.swift
//  What's Song?
//

import SwiftUI
import AVFoundation

class SoundPlayer {
    static var shared = SoundPlayer() // シングルトンインスタンス
    
    private var soundPlayer: AVAudioPlayer?
    
    private init() {
        // 初期化処理
    }
    
    func playEffectSound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("効果音ファイルが見つかりません")
            return
        }
        
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: url)
            soundPlayer?.play()
        } catch {
            print("効果音の再生に失敗しました")
        }
    }
}
