+++
title = "IAM権限を付与する"
weight = 300
+++

## スタックを実装する

`iac/lib/iac-stack.ts` を開きます。

```bash
code "$(git rev-parse --show-toplevel)/iac/lib/iac-stack.ts"
```

以下の内容に**全体を書き換えます**。

```typescript {hl_lines=["16","25"]}
import * as cdk from 'aws-cdk-lib/core';
import { Construct } from 'constructs';
import { NodejsFunction } from 'aws-cdk-lib/aws-lambda-nodejs';
import { Table, AttributeType, BillingMode } from 'aws-cdk-lib/aws-dynamodb';
import * as path from 'node:path';

export class IacStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const table = new Table(this, 'ItemTable', {
      partitionKey: { name: 'id', type: AttributeType.STRING },
      billingMode: BillingMode.PAY_PER_REQUEST,
    });

    const writeFunction = new NodejsFunction(this, 'Function', {
      entry: path.join(__dirname, '..', 'lambda', 'write.ts'),
      handler: 'handler',
      memorySize: 256,
      environment: {
        TABLE_NAME: table.tableName,
      },
    });

    table.grants.readWriteData(writeFunction);
  }
}
```

<!-- TODO: table.grants.readWriteData()が具体的に何をしているか（Lambdaの実行ロールにDynamoDBへの読み書きを許可するIAMポリシーを付与する）を説明する -->

## 差分を確認する

```bash
pnpm exec cdk diff
```

以下のような差分が表示されます。

```
IAM Statement Changes
┌───┬──────────────────┬────────┬───────────────────────────────────────┬──────────────────────────────┬───────────┐
│   │ Resource         │ Effect │ Action                                │ Principal                     │ Condition │
├───┼──────────────────┼────────┼───────────────────────────────────────┼──────────────────────────────┼───────────┤
│ + │ ${ItemTable.Arn} │ Allow  │ dynamodb:BatchGetItem                 │ AWS:${Function/ServiceRole}   │           │
│   │                  │        │ dynamodb:BatchWriteItem               │                               │           │
│   │                  │        │ dynamodb:ConditionCheckItem           │                               │           │
│   │                  │        │ dynamodb:DeleteItem                   │                               │           │
│   │                  │        │ dynamodb:DescribeTable                │                               │           │
│   │                  │        │ dynamodb:GetItem                      │                               │           │
│   │                  │        │ dynamodb:GetRecords                   │                               │           │
│   │                  │        │ dynamodb:GetShardIterator             │                               │           │
│   │                  │        │ dynamodb:PutItem                      │                               │           │
│   │                  │        │ dynamodb:Query                        │                               │           │
│   │                  │        │ dynamodb:Scan                         │                               │           │
│   │                  │        │ dynamodb:UpdateItem                   │                               │           │
└───┴──────────────────┴────────┴───────────────────────────────────────┴──────────────────────────────┴───────────┘
```

テーブルへの読み書きに必要な操作が`Allow`される、という意味の表です。

```
Resources
[+] AWS::IAM::Policy Function/ServiceRole/DefaultPolicy FunctionServiceRoleDefaultPolicy2F49994A
[~] AWS::Lambda::Function Function Function76856677
 └─ [~] DependsOn
     └─ 新しいIAMポリシーが追加される
```

- `IAM Statement Changes` … `table.grants.readWriteData()` によって、DynamoDBテーブルへの読み書きを許可するIAMポリシーが追加されることが分かります
- `[+] AWS::IAM::Policy` … 新しいIAMポリシーが作成される
- `[~] AWS::Lambda::Function` … Lambda関数自体は置き換えではなく、作成したポリシーへの依存関係（`DependsOn`）が追加される更新のみ

## デプロイする

```bash
pnpm exec cdk deploy
```

新しいIAMポリシーが追加されるため、[最初のアプリを作る]({{< ref "/30-first-app/300-deploy" >}})の時と同じくIAM変更の確認が表示されます。`y`を入力してデプロイを続行します。

```
Do you wish to deploy these changes? (y/n) y
```

## 確認

Lambda関数のページの「テスト」タブでもう一度テストを実行すると、今度は成功します。

![lambda test success](../images/40-add-resource/lambda-test-success.png)

前の章では権限不足で`AccessDeniedException`になっていましたが、`table.grants.readWriteData()`で付与した権限により、DynamoDBへの書き込みができるようになりました。

DynamoDBのテーブルページで「項目を探索」を開き、実際にデータが書き込まれているか確認してみましょう。

![dynamodb item](../images/40-add-resource/dynamodb-item.png)

`id`・`createdAt`を持つ項目が1件見つかりました。これはLambda関数のコード（`write.ts`）が`PutCommand`で書き込んだレコードです。テストを実行するたびに、新しい`id`を持つ項目が追加されます。
