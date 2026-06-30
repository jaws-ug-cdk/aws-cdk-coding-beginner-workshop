+++
title = "ツールのインストール"
weight = 200
+++

## このページについて

このページはサンプルです。CDK を動かすために必要なツールのインストール手順を書きます。

## 手順（サンプル）

コマンドはコードフェンスで囲みます。`monokai` スタイルでシンタックスハイライトされます。

```bash
# TODO: 実際のインストールコマンドに置き換える
npm install -g aws-cdk
cdk --version
```

バージョン番号など、共有データを埋め込みたい場合はショートコードを使えます。

- 例: `workshop/data/common.toml` の値を表示する → CDK バージョン: {{< cdkversion >}}

{{% notice note %}}
`{{</* cdkversion */>}}` は `workshop/layouts/shortcodes/cdkversion.html` で定義された
カスタムショートコードのサンプルです。値は `workshop/data/common.toml` で管理します。
{{% /notice %}}
