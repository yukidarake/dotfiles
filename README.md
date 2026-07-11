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

## dotfile の運用

### 状態を確認する

```sh
./bin/mise bootstrap dotfiles status
```

各行の状態は次の意味です。

- `applied`: リポジトリ内のファイルを指す symlink が適用済み
- `differs`: 対象は存在するが、期待する symlink ではない
- `missing`: 対象ファイルが存在しない
- `source missing`: `mise.toml` で指定したリンク元が存在しない

CI やスクリプトで未適用の有無を終了ステータスとして判定する場合は、`--missing` を付けます。

```sh
./bin/mise bootstrap dotfiles status --missing
```

### `differs` を解消する

`differs` のファイルへ即座に `--force` を指定すると、ホーム側にしかない変更を失う可能性があります。まずリポジトリ側と比較します。

```sh
git diff --no-index .config/herdr/config.toml ~/.config/herdr/config.toml
```

ホーム側を最新版として残す場合は、先にリポジトリへ取り込みます。

```sh
cp ~/.config/herdr/config.toml .config/herdr/config.toml
```

内容が同一、またはリポジトリ側を正とすると判断できたら、対象を限定して symlink へ置き換えます。

```sh
./bin/mise bootstrap dotfiles apply \
  ~/.config/herdr/config.toml \
  --force
```

複数の対象を一度に指定できます。実行内容だけを確認する場合は `--dry-run` を使います。

```sh
./bin/mise bootstrap dotfiles apply \
  ~/.config/herdr/config.toml \
  ~/.config/karabiner/karabiner.json \
  --force \
  --dry-run
```

### 普段の編集と保存

適用後のホーム側ファイルはリポジトリ内を指す symlink です。そのため、ホーム側をアプリやエディタから変更すると、変更はリポジトリの作業ツリーへ直接反映されます。

```sh
git status --short
./bin/mise run dotfiles-backup
```

`dotfiles-backup` は、このリポジトリで管理している設定ファイルだけを `Backup dotfiles` というメッセージで commit して push します。無関係な未追跡ファイルは含めません。

一部のアプリは設定保存時に symlink を通常ファイルへ置き換えることがあります。その場合は再度 `status` を確認し、ホーム側の変更をリポジトリへ取り込んでから `apply --force` します。

### Codex 設定

Codex 設定は公開リポジトリではなく、`~/ghq/github.com/yukidarake/dotfiles-private/codex/config.toml` で管理します。bootstrap 後の `~/.codex/config.toml` はこのファイルへの symlink なので、普段の編集内容は private repository の作業ツリーへ直接反映されます。

```sh
./bin/mise run codex-backup
```

このタスクは `codex/config.toml` だけを commit して private repository へ push します。

### 別のマシンへ反映する

各リポジトリを取得した後、最初に dry-run し、問題がなければ全体を適用します。

```sh
./bin/mise bootstrap --dry-run
./bin/mise bootstrap
```

既存dotfileとの競合がある場合だけ、内容を確認したうえで `--force-dotfiles` を指定します。
