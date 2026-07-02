+++
title = "cdk diff・deployコマンドを実行したら「--app is required」エラーになる"
weight = 300
+++

## 症状

`iac` ディレクトリではなく、リポジトリのルートなど別の場所で `pnpm exec cdk diff` や `pnpm exec cdk deploy` を実行すると、以下のようなエラーになります。

```
--app is required either in command-line, in cdk.json or in ~/.cdk.json
```

これは `cdk.json` が `iac` ディレクトリの中にしか無いためです。

## 対処法

`iac` ディレクトリに移動してから、再度実行してください。

```bash
cd "$(git rev-parse --show-toplevel)/iac"
```
