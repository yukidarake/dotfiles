# Usage
初回のみ
```
./setup.sh # いろいろ落としてくる
./brew.sh # Homebrew, HomebrewCaskのもろもろインストール
```

# Macでする設定

## タブでボタンを選択できるようにする
システム環境設定→キーボード→キーボードショートカット→すべてのコントロール

## COMMAND + F1をウィンドウ切り替えにする
システム環境設定→キーボード→キーボードショートカット

## ダブルタップでドラッグにする
システム環境設定→アクセシビリティ→マウスとトラックパッド→トラックパッドオプション→ドラッグを有効にする

## CTRL + ホイール回してズーム
アクセシビリティ→Zoom

# dashboardを無効にする
```
defaults write com.apple.dashboard mcx-disabled -boolean true
killall Dock
```

# アニメーション高速化
```
defaults write com.apple.dock expose-animation-duration -float 0.15
killall Dock
```

# COMMAND + TAB時の切り替えにアプリアイコンが出ないようにする
## Info.plistの編集
下記追記

```xml
  <key>NSUIElement</key>
  <string>1</string>
```
