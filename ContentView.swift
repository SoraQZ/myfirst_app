import SwiftUI
import AVFoundation

let musicData = NSDataAsset(name: "BGM")!.data
var musicPlayer: AVAudioPlayer!

struct ContentView: View {
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    @State private var isMuted = false // ミュートのフラグ
    @State private var volumeLevel: Float = 0.7 // 音量の初期値を0.7に設定（必要に応じて調整してください）
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                VStack() {
                    Spacer()
                    Text("What's Song?")
                        .font(.custom("Chalkduster", size: 45))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 50)
                        .scaleEffect(scale)
                        .animation(.linear(duration: 1.5).repeatForever(), value: scale)
                    Spacer()
                    
                    NavigationLink(destination: StageSelectionView(), isActive: $isActive) {
                        EmptyView()
                    }
                    .hidden()
                    
                    Button(action: {
                        SoundPlayer.shared.playEffectSound(soundName: "正解4") // ボタン効果音の再生
                        // ここに他のボタンが押されたときの処理を追加
                        isActive = true // NavigationLink をアクティベート
                    }) {
                        Text("スタート")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200)
                            .background(Color.green)
                            .cornerRadius(10)
                            .opacity(opacity)
                            .animation(.linear(duration: 2).repeatForever(), value: opacity)
                    }
                    Spacer()
                    
                    HStack(){
                        Button(action: {
                            isMuted.toggle() // Toggle mute state
                            if isMuted {
                                musicPlayer.pause() // Pause the music when muted
                            } else {
                                musicPlayer.play() // Resume the music when unmuted
                            }
                        }) {
                            Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.2.fill")
                                .frame(width: 30, height: 30)
                                .font(.system(size: 30))
                                .foregroundColor(.blue)
                                .padding(15)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: .gray, radius: 3, x: 0, y: 2)
                        }
                        
                        // Volume Slider
                        Slider(value: $volumeLevel, in: 0...1, step: 0.01) { _ in
                            // Adjust the volume of the music player when the slider value changes
                            musicPlayer.volume = volumeLevel
                        }
                        .accentColor(.white) // グレーのスライダーバーの色
                        .background(
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .fill(LinearGradient(gradient: Gradient(colors: [.gray, .gray]), startPoint: .leading, endPoint: .trailing)) // 右側の色を灰色に変更
                                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                                    Rectangle()
                                        .fill(LinearGradient(gradient: Gradient(colors: [.blue, .blue]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: CGFloat(volumeLevel) * geometry.size.width, height: geometry.size.height)
                                }
                                .cornerRadius(10)
                            }
                        )
                    }
                    .padding(50)
                    Spacer()
                }
                .onAppear {
                    playSound()
                    //musicPlayer.pause()
                    withAnimation {
                        self.scale = 1.1
                        self.opacity = 0.5
                    }
                }
            }
        }
        
        
        
    }
    
    func playSound() {
        do {
            musicPlayer = try AVAudioPlayer(data: musicData)
            musicPlayer.volume = 0.5 // 音量を0.5に設定（初期値を小さくしたい場合は適宜変更）
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch {
            print("音の再生に失敗しました。")
        }
    }
}


