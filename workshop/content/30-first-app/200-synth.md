+++
title = "合成（synth）する"
weight = 200
+++

## 手順

`iac` ディレクトリで実行します。

```bash
pnpm exec cdk synth
```

## 生成されたテンプレートを確認する

`cdk synth`によって、`cdk.out`ディレクトリにCloudFormationテンプレートが生成されます。

```bash
code "$(git rev-parse --show-toplevel)/iac/cdk.out/IacStack-dev.template.json"
```

Lambda関数やIAMロールなど、TypeScriptで書いたコードがCloudFormationのリソース定義に変換されていることが確認できます。
