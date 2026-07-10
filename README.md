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

パッケージ、dotfile、macOS 設定は [mise.toml](./mise.toml) で管理します。Git 設定、Fisher、vim-plug は [scripts/bootstrap](./scripts/bootstrap) にある `bootstrap` task で管理します。

macOS では、キーボードのフルキーボードアクセス、キーリピート、トラックパッドのドラッグ、Finder の隠しファイル表示、および `COMMAND + F1` でのウインドウ切り替えも bootstrap で設定されます。キーボードショートカットは、設定後のログアウトまたは再起動後に確実に反映されます。
