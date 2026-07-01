+++
title = "DynamoDBを追加する"
weight = 200
+++

## パッケージを追加する

`iac` ディレクトリで実行します。

```bash
pnpm add -D @aws-sdk/client-dynamodb @aws-sdk/lib-dynamodb
```

## Lambda関数を実装する

`iac/lambda/write.ts` を新規作成し、以下の内容にします（`hello.ts` は使わなくなります）。

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

## スタックを実装する

`iac/lib/iac-stack.ts` を、以下の内容で**全体を置き換えます**。

```typescript
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

    new NodejsFunction(this, 'WriteFunction', {
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

{{% notice note %}}
Lambda 関数の論理ID（コンストラクトID）を `HelloFunction` から `WriteFunction` に変更しています。
これにより、既存の Lambda 関数は削除され、新しい Lambda 関数が作成されます（置き換え）。
{{% /notice %}}

## 差分を確認してデプロイする

```bash
pnpm exec cdk diff
pnpm exec cdk deploy
```

この時点では、Lambda 関数に DynamoDB テーブルへの書き込み権限はまだありません。
