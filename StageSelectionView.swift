import SwiftUI

struct StageSelectionView: View {
    let stages: [String: String] = [
        "カラオケランキング": "ranking_karaoke202307",
        "６月のランキング": "ranking_6monthly",
        "２０２２年間ランキング": "2022_ranking",
        "２０２１年間ランキング": "2021_ranking",
        "ミリオンランキング": "ranking_million",
        // 他のファイル名と対応する日本語ファイル名を追加
    ]
    
    @State private var selectedStageFileName: String = ""
    @Environment(\.presentationMode) var presentationMode // presentationModeを取得
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    ForEach(stages.keys.sorted().reversed(), id: \.self) { key in
                        let value = stages[key] ?? ""
                        Button(action: {
                            selectedStageFileName = value
                            SoundPlayer.shared.playEffectSound(soundName: "スライドホイッスルファンファーレ1") // ボタン効果音ファイル名を適切に変更
                        }) {
                            Text(key)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 200)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        //.buttonStyle(PlainButtonStyle()) // Textをボタンにするためのスタイル
                    }
                }
                .padding()
            }
            .onAppear {
                // ビューが表示される際にselectedStageFileNameをリセットする
                selectedStageFileName = ""
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .background(
            NavigationLink(
                destination: SecondUIView(stageFileName: $selectedStageFileName),
                isActive: Binding<Bool>(
                    get: { !selectedStageFileName.isEmpty },
                    set: { _ in }
                )
            ) {
                EmptyView()
            }
        )
    }
    
    var backButton: some View {
        Button(action: {
            selectedStageFileName = ""
            presentationMode.wrappedValue.dismiss() // 1つ前の画面に戻る
            SoundPlayer.shared.playEffectSound(soundName: "正解4") // ボタン効果音ファイル名を適切に変更
        }) {
            Text("ホーム")
                .font(.headline)
                .foregroundColor(.blue)
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
        }
    }
}
