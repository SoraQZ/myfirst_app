# myfirst_app
# What's Song? - 歌詞推測クイズゲーム

![App Icon](Assets.xcassets/54DBB87F-17F3-4741-827A-6283BD680CD8.imageset/54DBB87F-17F3-4741-827A-6283BD680CD8.jpeg)

## 作った経緯

このアプリは、完全初見の私がXcodeとSwiftを使って作成したiPhoneアプリです。アプリのアイデアは、以前からあったものを取り入れています。

## アプリの解説

「What's Song?」は、曲名を当てるクイズゲームです。歌詞の単語がバラバラになった画像を見て、正しい曲名を推測することが目的です。難しい場合はヒントボタンを使用することもできます。さらに、曲名を見てもわからない場合はYouTubeやウェブで直接検索することもできます。

## 画像の生成方法

アプリはあらかじめ生成された画像を読み込んで表示しています。元の画像は、楽曲サイトのランキングなどから歌詞を取得し、Google Colabを使用して形態素解析などを行って生成されています。

## 注意事項

現在、正誤判定機能は実装されていません。この機能は工夫が必要であるため、今後のアップデートで実装を検討しています。

## バグと改善点

アプリにはまだ改善が必要な点がいくつかありますが、致命的な欠陥ではないため放置しています。以下は一部の課題です。
- ミュートボタンを押しても、遷移時のボタンの音がミュートされない
- ミュートボタンを押した状態でタイトル画面に戻ると、ミュートが解除される

## ライセンス
Copyright (c) 2023 SoraQZ

このソフトウェアおよび関連文書ファイル（以下「ソフトウェア」）の複製を入手する全ての人に対し、以下の条件に従ってソフトウェアを取り扱うことを無償で許可します。

上記の著作権表示および本許諾表示を、ソフトウェアのすべての複製または重要な部分に記載するものとします。

商用利用を含む、以下の利用は禁止されます：
- このソフトウェアを利用した商品の販売
- このソフトウェアを利用したサービスの提供

ソフトウェアは「現状のまま」提供され、明示黙示を問わず、商品性および特定の目的への適合性を含むがこれに限定されない、いかなる種類の保証もなく提供されます。著作権者または著作権者の代理人は、契約行為、不法行為またはその他の行為に関して、ソフトウェアに起因または関連し、またはソフトウェアの使用またはその他の扱いによって生じる一切の請求、損害またはその他の義務について責任を負うものではありません。
