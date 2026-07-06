+++
title = "AWSにログインする"
weight = 100
+++

## 手順

ブラウザからAWSアカウントにサインインします。

https://console.aws.amazon.com/

画面右上のリージョンが「東京」（`ap-northeast-1`）になっていることを確認します。違うリージョンになっている場合は、リージョンの一覧から「東京」を選択してください。

![select region](../images/20-getting-started/select-region.png)

続いて、GitHub Codespacesのターミナルで以下のコマンドを実行します。

```bash
aws login --remote
```

{{% notice note %}}
ターミナルに初めて貼り付けする際、ブラウザからクリップボードへのアクセス許可を求められることがあります。その場合は`Allow`を押してください。
{{% /notice %}}

リージョンを聞かれたら`ap-northeast-1`を入力します。

```
AWS Region [us-east-1]: ap-northeast-1
```

ターミナルにURLが表示されるので、コピーしてブラウザに貼り付けて開きます。

ブラウザに表示された`検証コードをコピー`ボタンでコードをコピーし、ターミナルに貼り付けてログインを完了します。
