+++
title = "スタックを削除する"
weight = 100
+++

## 手順

`iac` ディレクトリで実行します。

```bash
pnpm exec cdk destroy
```

## リソースが残ってしまった場合

`cdk destroy` で削除できないリソースが残ってしまった場合は、[delstack](https://github.com/go-to-k/delstack) というツールで強制的に削除できます。nixpkgs には無いため、GitHub Releases からバイナリを取得してください。

```bash
delstack -s IacStack
```
