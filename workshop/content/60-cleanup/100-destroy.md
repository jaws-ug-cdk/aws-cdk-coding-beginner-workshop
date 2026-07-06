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

## 確認

AWS マネジメントコンソールの画面上部の検索窓に`CloudFormation`と入力し、表示された`CloudFormation`を選択します。

![search CloudFormation](../images/20-getting-started/search-cloudformation.png)

スタックの一覧に`CDKToolkit`以外のスタックが存在しないことを確認します。`IacStack-dev`・`IacStack-prod`が表示されていなければ、削除は完了です。

![stacks list](../images/60-cleanup/stacks-list.png)
