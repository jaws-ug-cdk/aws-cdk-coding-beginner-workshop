+++
title = "はじめる前に"
weight = 100
+++

## 手順

このワークショップでは [GitHub Codespaces](https://github.co.jp/features/codespaces) を使って進めます。起動に数分かかるため、最初に立ち上げておきましょう。

### 1. リポジトリを作成する

以下のリンクをクリックして、新しいGitHubリポジトリを作成します。
[https://github.com/new?template_name=cdk-workshop-template&template_owner=jaws-ug-cdk](https://github.com/new?template_name=cdk-workshop-template&template_owner=jaws-ug-cdk)

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

画面が遷移してCodespacesが作成されます。起動を待っている間に、次のページを読み進めてください。

このような画面になったら起動完了です！

![started codespaces](../images/20-getting-started/started-codespaces.png)

画面下部の`TERMINAL`パネルがターミナルです。以降の手順ではここにコマンドを入力していきます。

{{% notice tip %}}
コマンドが動かなくなった場合は、[トラブルシューティング]({{< ref "/95-troubleshooting" >}})を確認してください。
{{% /notice %}}
