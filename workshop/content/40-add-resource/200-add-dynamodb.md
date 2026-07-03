+++
title = "DynamoDBを追加する"
weight = 200
+++

## Lambda関数を実装する

`iac/lambda/write.ts` を開きます。

```bash
code "$(git rev-parse --show-toplevel)/iac/lambda/write.ts"
```

以下の内容に書き換えます。

```typescript
import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient, PutCommand } from '@aws-sdk/lib-dynamodb';
import { randomUUID } from 'node:crypto';

const client = DynamoDBDocumentClient.from(new DynamoDBClient({}));

export const handler = async (): Promise<{ statusCode: number; body: string }> => {
  await client.send(
    new PutCommand({
      TableName: process.env.TABLE_NAME,
      Item: {
        id: randomUUID(),
        createdAt: new Date().toISOString(),
      },
    }),
  );

  return {
    statusCode: 200,
    body: 'ok',
  };
};
```

<!-- TODO: TableコンストラクトのpartitionKey/billingModeとは何かを説明する -->

## スタックを実装する

`iac/lib/iac-stack.ts` を開きます。

```bash
code "$(git rev-parse --show-toplevel)/iac/lib/iac-stack.ts"
```

以下の内容に**全体を書き換えます**。

```typescript {hl_lines=["4","11-14","17","20-22"]}
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

    new NodejsFunction(this, 'Function', {
      entry: path.join(__dirname, '..', 'lambda', 'write.ts'),
      handler: 'handler',
      memorySize: 256,
      environment: {
        TABLE_NAME: table.tableName,
      },
    });
  }
}
```

## 差分を確認する

```bash
pnpm exec cdk diff
```

以下のような差分が表示されます。

```
Resources
[+] AWS::DynamoDB::Table ItemTable ItemTable276B2AC8
[~] AWS::Lambda::Function Function Function76856677
 ├─ [~] Code
 │   └─ [~] .S3Key:
 │       ├─ [-] 381bee9be0df3581b7129445475a6cbf7ee4d34efa8a7c5e1246826698e71048.zip
 │       └─ [+] ea3c8139d040e379c0f95e9f72661ac6b1e8e25ada09c5a318871b1838ce77f9.zip
 └─ [+] Environment
     └─ {"Variables":{"TABLE_NAME":{"Ref":"ItemTable276B2AC8"}}}
```

- `[+] AWS::DynamoDB::Table` … DynamoDBテーブルが新規追加される
- `[~] AWS::Lambda::Function Function` … 既存のLambda関数が**更新**される
  - `Code.S3Key` … Lambda関数のコードが `write.ts` の内容に更新される
  - `Environment` … 環境変数 `TABLE_NAME` が追加される

## デプロイする

```bash
pnpm exec cdk deploy
```

## 確認

AWS マネジメントコンソールの画面上部の検索窓に`CloudFormation`と入力し、表示された`CloudFormation`を選択します。

![search CloudFormation](../images/20-getting-started/search-cloudformation.png)

`IacStack-dev`スタックを開きます。「リソース」タブで`ItemTable`を展開し、`AWS::DynamoDB::Table`が`CREATE_COMPLETE`になっていることを確認します。物理IDリンクをクリックするとDynamoDBのテーブルページに移動します。

![stack resources](../images/40-add-resource/dynamodb-stack-resources.png)

テーブルが作成されていることを確認します。

![dynamodb table page](../images/40-add-resource/dynamodb-table-page.png)

この時点では、Lambda 関数に DynamoDB テーブルへの書き込み権限はまだありません。試しにLambda関数のページで「テスト」タブからテストを実行すると、`AccessDeniedException`で失敗します。

![lambda test fail](../images/40-add-resource/lambda-test-fail.png)

`dynamodb:PutItem`を実行する権限がないため、書き込みに失敗しています。次の章でこの権限を付与します。
