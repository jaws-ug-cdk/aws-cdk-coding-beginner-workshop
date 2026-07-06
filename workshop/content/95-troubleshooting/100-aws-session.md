+++
title = "「Unable to resolve AWS account」エラー"
weight = 100
+++

## 症状

しばらく操作せずにいると、AWSへのログインセッションが切れることがあります。その状態で `cdk diff` や `cdk deploy` を実行すると、以下のようなエラーになります。

```
Unable to resolve AWS account to use. It must be either configured when you define your CDK Stack, or through the environment
```

## 対処法

以下のコマンドを実行して、再度ログインします。

```bash
aws login --remote
```

あとは[AWSにログインする]({{< ref "/20-getting-started/100-aws-login" >}})の手順と同じです。
