# JecNavi - （非）公式学校アプリ

## 概要

JecNaviは、学校生活をサポートするために開発されたアプリです。学生や教職員、保護者の方が学校情報にアクセスしやすくし、コミュニケーションを円滑にすることを目的としています。

## 主な機能

- **チャット機能**: 学生同士や教職員とのコミュニケーションをサポート
- **匿名タイムライン**: 学生が匿名で意見や感想を共有できる場
- **マップ機能**: 学校の施設や教室の位置を確認できるインタラクティブマップ
- **公式ニュース**: 学校からのお知らせやニュースをリアルタイムで提供
- **リンク集**: 重要な学校関連リンクを一箇所に集約

## 作成動機

このアプリは、学生が日々の学校生活をよりスムーズに送れるようにするために開発されました。既存の学校システムでは不足している機能を補い、学生間のコミュニケーションを強化することを目指しています。また、建物が離れているため新入生や保護者の方、初めていく建物へのアクセスがより便利になることを目標に作成しました。

## 技術スタック

- **プログラミング言語**: Swift
- **フレームワーク**: SwiftUI
- **バックエンド**: Firebase
- **API**: Python
- **デプロイメント**: Render/GAS
- **その他主要ライブラリ**: 
  - Alamofire (ネットワーキング)
  - WebViewKit (アプリ内Web)
  - MapKit (マップ)
  - CodeScanner/QRCode (QR機能) 
  - Firebase Authentication (ユーザー認証)
  - Firebase Firestore (データベース)



## 工夫した点

- **UI/UX**: 様々なアプリのUIや画面遷移を参考にし、直感的で使いやすいインターフェースを実現
- **リアルタイム更新**: Firebaseを使用することで、チャットやニュースのリアルタイム更新を実現
- **匿名性の確保**: 匿名タイムライン機能ではユーザーのプライバシーを保護しつつ、意見交換が活発に行えるように工夫
- **パフォーマンスの最適化**: xclogparserなどのツールを使用してビルドパフォーマンスを向上

## 使い方

チャット、匿名タイムライン（投稿）のご利用には日本電子専門学校のアカウントが必要です。

## API

こちらのサイトにて詳しい説明を載せております。
(https://github.com/dlxsmd/jecapi)

## リリースについて
現在、学校側への提案段階でまだAppStoreへのリリースはできていませんが、11月の文化祭でご来場いただく方々に使っていただくために準備を進めています。
