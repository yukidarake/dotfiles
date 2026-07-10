# dotfiles

## セットアップ

`mise` や Homebrew を事前にインストールする必要はありません。リポジトリに同梱したランチャーが、固定バージョンの `mise` を検証して取得します。

```sh
git clone https://github.com/yukidarake/dotfiles.git
cd dotfiles
./bin/mise bootstrap
```

既存ファイルとの競合を確認する場合は、先に dry-run します。

```sh
./bin/mise bootstrap --dry-run
```

競合する dotfile をリポジトリ側の symlink で置き換えてよい場合のみ、`--force-dotfiles` を指定します。

```sh
./bin/mise bootstrap --force-dotfiles
```

セットアップは冪等なので、構成を更新した後も同じコマンドを再実行できます。現在の状態だけを確認するには次を実行します。

```sh
./bin/mise bootstrap status --missing
```

パッケージ、dotfile、macOS defaults は [mise.toml](./mise.toml) で管理します。Git 設定、Fisher、vim-plug は [scripts/bootstrap](./scripts/bootstrap) にある `bootstrap` task で管理します。

## Macでする設定

### タブでボタンを選択できるようにする

システム環境設定→キーボード→キーボードショートカット→すべてのコントロール

### COMMAND + F1をウィンドウ切り替えにする

システム環境設定→キーボード→キーボードショートカット

### ダブルタップでドラッグにする

システム環境設定→アクセシビリティ→マウスとトラックパッド→トラックパッドオプション→ドラッグを有効にする

## トラックパッド

### ダブルクリックでドラッグ可能に

アクセシビリティ→マウス＆トラックパッド→トラックパッドオプション

## COMMAND + TAB時の切り替えにアプリアイコンが出ないようにする

### Info.plistの編集

下記追記

```xml
  <key>NSUIElement</key>
  <string>1</string>
```
