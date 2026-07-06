+++
title = "DynamoDBを追加する"
weight = 200
+++

## Lambda関数を実装する

`iac/lambda/write.ts` を開きます。GitHub Codespacesのターミナルで次のコマンドを実行します。

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

`iac/lib/iac-stack.ts` を開きます。ターミナルで次のコマンドを実行します。

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

次のコマンドをターミナルで実行します。

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
 │       ├─ [-] <古いasset-hash>.zip
 │       └─ [+] <新しいasset-hash>.zip
 └─ [+] Environment
     └─ {"Variables":{"TABLE_NAME":{"Ref":"ItemTable276B2AC8"}}}
```

- `[+] AWS::DynamoDB::Table` … DynamoDBテーブルが新規追加される
- `[~] AWS::Lambda::Function Function` … 既存のLambda関数が**更新**される
  - `Code.S3Key` … Lambda関数のコードが `write.ts` の内容に更新される
  - `Environment` … 環境変数 `TABLE_NAME` が追加される

## デプロイする

次のコマンドをターミナルで実行します。

```bash
pnpm exec cdk deploy
```

## 確認

`IacStack-dev`スタックを再度開きます。「リソース」タブで`ItemTable`を展開すると、`AWS::DynamoDB::Table`が`CREATE_COMPLETE`になっています。

![stack resources](../images/40-add-resource/dynamodb-stack-resources.png)

この時点では、Lambda 関数に DynamoDB テーブルへの書き込み権限はまだありません。試しにLambda関数のページで「テスト」タブからテストを実行すると、`AccessDeniedException`で失敗します。

![lambda test fail](../images/40-add-resource/lambda-test-fail.png)
