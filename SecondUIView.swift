import SwiftUI
import AVKit

struct SecondUIView: View {
    @State private var opacity: Double = 1.0
    @State private var imageOpacity: Double = 0.0
    @State private var showImage = false // Imageを表示するかどうかのフラグ
    @State private var showButton = false
    @State private var hintoName = ""
    @State private var buttonName = "ヒント"
    @State private var showModal = false // AnswerUIViewを表示するかどうかのフラグ
    @State private var toggle = false //画面タップでのimageButtomの切り替えの許可、不許可
    @State private var nextButtom = false
    @Environment(\.presentationMode) var presentationMode // presentationModeを取得
    @Binding var stageFileName: String // @Bindingに変更
    
    
    // CSVファイルのパス
    var csvFilePath: String? {
        Bundle.main.path(forResource: stageFileName, ofType: "csv")
    }
    // ランダムに取得する曲名を用意します
    @State private var songTitle: String = ""
    
    // ランダムな曲情報を取得する関数
    func getRandomSongInfo() -> [[String]]? {
        guard let csvString = try? String(contentsOfFile: csvFilePath ?? "", encoding: .utf8) else {
            print("Error reading CSV file.")
            return nil
        }
        
        let rows = csvString.components(separatedBy: "\n")
        var songInfo: [[String]] = []
        
        for row in rows {
            let columns = row.components(separatedBy: ",")
            if columns.count >= 3 {
                let artist = columns[2].trimmingCharacters(in: .whitespaces)
                let song = columns[0].trimmingCharacters(in: .whitespaces)
                let info = [song, artist]
                songInfo.append(info)
            }
        }
        
        return songInfo
    }
    
    // 使用例
    
    var body: some View {
        ZStack {
            
            
            Color.blue
                .ignoresSafeArea()
            
            ZStack() {
                // 画像を表示
                if showImage, !songTitle.isEmpty {
                    Image(songTitle) // 画像名に適切な画像ファイル名を入れる
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 700) // 画像サイズを調整
                        .opacity(imageOpacity) // フェードイン・フェードアウトのためにopacityを適用
                }
                
                Text("何の曲でしょう？")
                    .font(.custom("HiraKakuProN-W6", size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 0)
                    .lineSpacing(8)
                    .kerning(1)
                    .opacity(opacity) // フェードイン・フェードアウトのためにopacityを適用
                if showButton {
                    Color.gray
                        .ignoresSafeArea()
                        .opacity(0.65) // 透け具合を0.5に設定（半透明）
                    
                }
            }
            
            .animation(.linear(duration: 1.5), value: opacity) // opacityの値が変化した時に1.5秒かけてフェードアウトするアニメーション
            .animation(.easeInOut(duration: 1.5), value: imageOpacity) // 1.5秒かけてフェードインするアニメーション
            
            // 画面をタップしたときにボタンを表示させる
            // ボタンを表示する条件によって、ボタンを表示または非表示にする
            if showButton {
                VStack {
                    Button(action: {
                        buttonName = hintoName
                        SoundPlayer.shared.playEffectSound(soundName: "正解4") // ボタン効果音ファイル名を適切に変更
                    }) {
                        Text(buttonName) // 親ビューのミュート状態に応じてテキストを切り替える
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        // ボタンがタップされた時の処理
                        SoundPlayer.shared.playEffectSound(soundName: "正解4") // ボタン効果音ファイル名を適切に変更
                        print("Button tapped　回答を見る")
                        // ボタンをタップしたらAnswerUIViewを表示する
                        showModal = true
                    }) {
                        Text("回答を見る")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding()
                    Button(action: {
                        buttonName = "ヒント"
                        showButton = false
                        startMotion()
                        SoundPlayer.shared.playEffectSound(soundName: "正解4") // ボタン効果音ファイル名を適切に変更
                        
                    }) {
                        Text("次の問題") // 親ビューのミュート状態に応じてテキストを切り替える
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
            
        }
        .onAppear {
            startMotion()
        }
        .onTapGesture {
            // 画面をタップした時に、showButtonの値を反転させる
            if toggle {showButton.toggle()
                SoundPlayer.shared.playEffectSound(soundName: "決定2") // ボタン効果音ファイル名を適切に変更
            }
        }
        .sheet(isPresented: $showModal) {
            AnswerUIView(songTitle: songTitle)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        
        
    }
    var backButton: some View {
        // ホワイトの背景に青い文字でホームを表示するボタン
        Button(action: {
            // モーダル遷移の戻るボタンが押された時の処理
            SoundPlayer.shared.playEffectSound(soundName: "決定2") // ボタン効果音ファイル名を適切に変更
            presentationMode.wrappedValue.dismiss() // 1つ前の画面に戻る
        }) {
            Text("ステージ")
                .font(.headline)
                .foregroundColor(.blue)
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
        }
    }
    func startMotion (){
        imageOpacity = 0.0
        showImage = false //イメージ画面のリッセット
        toggle = false //画面タップでのimageButtomの切り替えの不許可
        // 使用例
        if let songInfoList = getRandomSongInfo() {
            if let randomIndex = songInfoList.indices.randomElement() {
                let randomSongInfo = songInfoList[randomIndex]
                let randomSongTitle = randomSongInfo[0] // 曲名
                let randomArtistName = randomSongInfo[1] // アーティスト名
                hintoName = randomArtistName
                print(hintoName)
                songTitle = randomArtistName + " " + randomSongTitle
            }
        }
        // 曲名をランダムに取得
        print(csvFilePath ?? "")
        
        // ビューが表示されたら1.5秒後にTextのopacityを0にしてフェードアウトさせる
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                opacity = 0
            }
        }
        // 3秒後にImageを表示するフラグをtrueにしてImageを表示させる
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showImage = true
            withAnimation {
                imageOpacity = 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            toggle = true //画面タップでのimageButtomの切り替えの許可
        }
    }
    
}
/*
 struct SecondUIView_Previews: PreviewProvider {
 static var previews: some View {
 SecondUIView()//quizList)//:["Sweet RainWOLF HOWL HARMONY Sweet Rain"])
 }
 }
 */
