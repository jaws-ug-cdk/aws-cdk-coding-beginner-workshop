+++
title = "スタックを削除する"
weight = 100
+++

## 手順

`iac` ディレクトリで、dev と prod それぞれ実行します。

```bash
pnpm exec cdk destroy -c env=dev
pnpm exec cdk destroy -c env=prod
```

それぞれ、削除してよいか確認されるので`y`を入力します。

```
Are you sure you want to delete: IacStack-dev (y/n)? y
```
