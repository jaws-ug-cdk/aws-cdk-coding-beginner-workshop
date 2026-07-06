+++
title = "CDK Bootstrap"
weight = 300
+++

<!-- TODO: cdk bootstrapが何のために必要か（CDKToolkitスタック・デプロイ用アセットの置き場所など）を説明する -->

## 手順

AWSアカウントにてCDKデプロイできるように`cdk bootstrap`コマンドを実行します。

```bash
pnpm exec cdk bootstrap
```

## 確認

AWS マネジメントコンソールの画面上部の検索窓に`CloudFormation`と入力し、表示された`CloudFormation`を選択します。

![search CloudFormation](../images/20-getting-started/search-cloudformation.png)

`CDKToolkit`スタックが`CREATE_COMPLETE`になっていることを確認します。

![CDKToolkit stack](../images/20-getting-started/cdktoolkit-stack.png)

これで環境準備は完了です。次の章では、実際に Lambda 関数を実装していきます。
