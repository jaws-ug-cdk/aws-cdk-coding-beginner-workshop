+++
title = "デプロイする"
weight = 300
+++

## 手順

`iac` ディレクトリで実行します。

```bash
pnpm exec cdk deploy
```

## IAM変更の確認

Lambda 関数の実行ロール（IAMロール・ポリシー）が新規作成されるため、途中で変更内容の確認が表示されます。内容を確認し、`y` を入力してデプロイを続行します。

```
Do you wish to deploy these changes? (y/n) y
```

{{% notice note %}}
IAMロールやポリシーなど、セキュリティに関わるリソースの変更がある場合、`cdk deploy` はデフォルトで確認を挟みます。
{{% /notice %}}

## 確認

AWS マネジメントコンソールの画面上部の検索窓に`CloudFormation`と入力し、表示された`CloudFormation`を選択します。

![search CloudFormation](../images/20-getting-started/search-cloudformation.png)

`IacStack-dev`スタックを開きます。「リソース」タブで`Function`を展開し、`AWS::Lambda::Function`の物理IDリンクをクリックしてLambda関数のページに移動します。

![stack resources](../images/30-first-app/stack-resources.png)

Lambda関数のページに移動します。

![lambda function page](../images/30-first-app/lambda-function-page.png)

「テスト」タブを開き、画面右上の`テスト`ボタンをクリックして関数を実行します。

![lambda test button](../images/30-first-app/lambda-test-button.png)

`"body": "Hello, CDK!"`が返ってくることを確認します。

![lambda test result](../images/30-first-app/lambda-test-result.png)

次の章では、このアプリを更新していきます。
