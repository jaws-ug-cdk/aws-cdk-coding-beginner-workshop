+++
title = "ツールのインストール"
weight = 200
+++

## このページについて

このハンズオンでは [GitHub Codespaces](https://github.co.jp/features/codespaces) を使って進めます！

## 手順

### 1. リポジトリを作成する

以下のリンクをクリックして、新しいGitHubリポジトリを作成します。

[https://github.com/codespaces/new?template_repository={{< templaterepo >}}](https://github.com/codespaces/new?template_repository={{< templaterepo >}})

以下を設定して`Create repository`ボタンを押してリポジトリを作成します。

- リポジトリ名: `{{< reponame >}}-yyyymmdd`
- 公開設定: `Private`

{{% notice note %}}
`yyyymmdd`の部分は今日の日付に置き換えてください（例: 2026年7月2日なら`20260702`）。何度もこのワークショップに参加してリポジトリを作り直しても、日付が違えば名前が重複しません。
{{% /notice %}}


![create repository](../images/20-getting-started/create-repository.png)

### 2. GitHub Codespacesを起動する

`Code`ボタンから`Codespaces`タブを開き、`Create codespace on main`ボタンを押します。

![create codespaces](../images/20-getting-started/create-codespaces.png)

すると画面が遷移してCodespacesが作成されるのでしばらく待ちます。

このような画面になったら起動完了です！

![started codespaces](../images/20-getting-started/started-codespaces.png)

画面下部の`TERMINAL`パネルがターミナルです。以降の手順ではここにコマンドを入力していきます。

{{% notice tip %}}
コマンドが動かなくなった場合は、[トラブルシューティング]({{< ref "/95-troubleshooting" >}})を確認してください。
{{% /notice %}}
