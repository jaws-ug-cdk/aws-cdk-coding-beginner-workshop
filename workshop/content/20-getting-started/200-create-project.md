+++
title = "プロジェクトを作成する"
weight = 200
+++

## 手順

次のコマンドでAWS CDKプロジェクトを作成します。

```bash
cd iac
pnpm dlx cdk init app -l ts --package-manager pnpm
```

`iac` ディレクトリの中にCDKを実行するためのファイル群が作成されます。

## パッケージを追加する

このワークショップで後ほど使用するパッケージを、まとめて追加しておきます。

```bash
pnpm add -D esbuild@0.28.1 @aws-sdk/client-dynamodb@3.1078.0 @aws-sdk/lib-dynamodb@3.1078.0
pnpm approve-builds --all
```
