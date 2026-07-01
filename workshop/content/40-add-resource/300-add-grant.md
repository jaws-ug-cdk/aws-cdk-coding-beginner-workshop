+++
title = "IAM権限を付与する"
weight = 300
+++

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

    const writeFunction = new NodejsFunction(this, 'WriteFunction', {
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

{{% notice note %}}
`table.grants.readWriteData()` は、DynamoDB テーブルへの読み書き権限を IAM ロールに付与する新しい API です。
従来の `table.grantReadWriteData()` の後継として使います。
{{% /notice %}}

## 差分を確認する

```bash
pnpm exec cdk diff
```

## デプロイする

```bash
pnpm exec cdk deploy
```
