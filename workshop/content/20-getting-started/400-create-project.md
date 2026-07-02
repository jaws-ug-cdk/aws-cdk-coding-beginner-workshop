+++
title = "プロジェクトを作成する"
weight = 400
+++

## 手順

```bash
cd iac
pnpm dlx cdk init app -l ts --package-manager pnpm
```

`iac` ディレクトリの中に、以下のファイルが生成されます。

- `bin/iac.ts` … アプリのエントリポイント
- `lib/iac-stack.ts` … スタック定義（`IacStack` クラス）

{{% notice note %}}
以降の手順は、すべて `iac` ディレクトリで実行する前提で書かれています。ターミナルを開き直した際は `cd iac` を忘れずに実行してください。
{{% /notice %}}

## パッケージを追加する

このワークショップで後ほど使用するパッケージを、まとめて追加しておきます。

```bash
pnpm add -D esbuild@0.28.1 @aws-sdk/client-dynamodb@3.1078.0 @aws-sdk/lib-dynamodb@3.1078.0
pnpm approve-builds --all
```
