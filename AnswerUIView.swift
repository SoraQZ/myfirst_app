//
//  AnswerUIView.swift
//  What's Song?
//
// 
//

import SwiftUI
import SafariServices

struct AnswerUIView: View {
    @Environment(\.presentationMode) var presentationMode
    let songTitle: String
    //var nextQuiz: Bool
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                HStack{
                    VStack{
                        /*
                         Button(action: {
                         // 検索アクションを実行する処理をここに追加
                         print("Apple music")
                         //openYouTubeInSafari()
                         AppleseachMusic()
                         }) {
                         Image(systemName: "apple.logo")
                         .resizable()
                         .frame(width: 40, height: 40)
                         .foregroundColor(.blue)
                         }
                         Text("Apple music")
                         .foregroundColor(.white)
                         */
                    }
                    Spacer()
                    VStack{
                        Button(action: {
                            // 検索アクションを実行する処理をここに追加
                            print("YouTubeで検索します")
                            //openYouTubeInSafari()
                            YoutubeseachMusic()
                            SoundPlayer.shared.playEffectSound(soundName: "正解4") // ボタン効果音ファイル名を適切に変更
                        }) {
                            Image(systemName: "play.rectangle.fill")
                                .resizable()
                                .frame(width: 60, height: 40)
                                .foregroundColor(.blue)
                        }
                        Text("YouTubeで検索")
                            .foregroundColor(.white)
                        
                    }
                    Spacer()
                    /*
                     VStack{
                     Button(action: {
                     // 検索アクションを実行する処理をここに追加
                     print("LINE MUSICで検索")
                     //openYouTubeInSafari()
                     LineseachMusic()
                     }) {
                     Image(systemName: "message.fill")
                     .resizable()
                     .frame(width: 50, height: 40)
                     .foregroundColor(.blue)
                     }
                     Text("LINE music")
                     .foregroundColor(.white)
                     
                     }*/
                    VStack{
                        Button(action: {
                            // 検索アクションを実行する処理をここに追加
                            print("Safariで検索します")
                            //openYouTubeInSafari()
                            GoogleseachMusic()
                            SoundPlayer.shared.playEffectSound(soundName: "正解4") // ボタン効果音ファイル名を適切に変更
                        }) {
                            Image(systemName: "safari.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue)
                        }
                        Text("Webで検索")
                            .foregroundColor(.white)
                        
                    }
                    Spacer()
                }
                Spacer()
                VStack(){
                    Text("答えは！")
                        .font(.custom("HiraKakuProN-W6", size: 25))
                        .foregroundColor(.white)
                        .padding()
                    
                    Text(songTitle)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 100)
                }
                Spacer()
                Button(action: {
                    print(songTitle)
                    //nextQuiz = true
                    presentationMode.wrappedValue.dismiss()
                    
                    SoundPlayer.shared.playEffectSound(soundName: "正解4") // ボタン効果音ファイル名を適切に変更
                }){
                    Text("閉じる")
                        .foregroundColor(.white)
                        .font(.custom("HiraKakuProN-W6", size: 20))
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.bottom, 50)
                }
                Spacer()
            }
        }
    }
    func AppleseachMusic() {
        if let encodedSearchTerm = songTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: "https://music.apple.com/jp/search?term=\(encodedSearchTerm)") {
            UIApplication.shared.open(url)
        }
    }
    func YoutubeseachMusic() {
        if let encodedSearchTerm = songTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: "https://www.youtube.com/results?search_query=\(encodedSearchTerm)") {
            UIApplication.shared.open(url)
        }
    }
    func LineseachMusic() {
        if let encodedSearchTerm = songTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: "https://music.line.me/search?query=\(encodedSearchTerm)") {
            UIApplication.shared.open(url)
        }
    }
    func
    GoogleseachMusic() {
        if let encodedSearchTerm = songTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: "https://www.google.co.jp/search?q=\(encodedSearchTerm)&oe=UTF-8&hl=ja-jp&client=safari") {
            UIApplication.shared.open(url)
        }
    }
}

struct AnswerUIView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerUIView(songTitle: "サンプル曲名")//,nextQuiz: false)
    }
}
