+++
title = "デプロイする"
weight = 300
+++

## 手順

いよいよCDKで実装したLambda関数をAWSへデプロイします。
次のコマンドをGitHub Codespacesのターミナルで実行してください。

```bash
pnpm exec cdk deploy
```

デプロイ中にCDKアプリが合成された後、IAM権限が変更されている箇所がリストアップされます。
ここでは、Lambda 関数の実行ロール（IAMロール・ポリシー）が新規作成されています。

```md
IAM Statement Changes
┌───┬─────────────────────────────┬────────┬────────────────┬──────────────────────────────┬───────────┐
│   │ Resource                    │ Effect │ Action         │ Principal                    │ Condition │
├───┼─────────────────────────────┼────────┼────────────────┼──────────────────────────────┼───────────┤
│ + │ ${Function/ServiceRole.Arn} │ Allow  │ sts:AssumeRole │ Service:lambda.amazonaws.com │           │
└───┴─────────────────────────────┴────────┴────────────────┴──────────────────────────────┴───────────┘
IAM Policy Changes
┌───┬─────────────────────────┬────────────────────────────────────────────────────────────────────────────────┐
│   │ Resource                │ Managed Policy ARN                                                             │
├───┼─────────────────────────┼────────────────────────────────────────────────────────────────────────────────┤
│ + │ ${Function/ServiceRole} │ arn:${AWS::Partition}:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole │
└───┴─────────────────────────┴────────────────────────────────────────────────────────────────────────────────┘
```

`y` を入力してデプロイを続行します。

```
Do you wish to deploy these changes? (y/n) y
```

## 確認

AWS マネジメントコンソールの画面上部の検索窓に`CloudFormation`と入力し、表示された`CloudFormation`を選択します。

![search CloudFormation](../images/20-getting-started/search-cloudformation.png)

`IacStack-dev`スタックを開きます。「リソース」タブで`Function`を展開し、`AWS::Lambda::Function`の物理IDリンクをクリックしてLambda関数のページに移動します。

![stack resources](../images/30-first-app/stack-resources.png)

Lambda関数のページで「テスト」タブを開きます。

![lambda function page](../images/30-first-app/lambda-function-page.png)

画面右上の`テスト`ボタンをクリックして関数を実行します。

![lambda test button](../images/30-first-app/lambda-test-button.png)

実行中の関数の詳細を開き、`"body": "Hello, CDK!"`が返ってくることを確認します。

![lambda test result](../images/30-first-app/lambda-test-result.png)

次の章では、このアプリを更新していきます。
