+++
title = "プロジェクトを作成する"
weight = 100
+++

## このページについて

このページはサンプルです。新しい CDK プロジェクトの作成手順を書きます。

```bash
mkdir cdk-workshop && cd cdk-workshop
# TODO: 採用する言語に合わせて --language を変更
cdk init sample-app --language typescript
```

## プロジェクト構成（サンプル）

生成されたファイル構成の説明を、必要に応じて表や箇条書きで示します。

- `bin/` … アプリのエントリポイント
- `lib/` … スタック定義
- `cdk.json` … CDK Toolkit の設定

実際に動かすサンプルコードは、リポジトリの `code/` ディレクトリに置きます
（[code/README.md](https://github.com/jaws-ug-cdk/aws-cdk-coding-beginner-workshop/tree/main/code) を参照）。
