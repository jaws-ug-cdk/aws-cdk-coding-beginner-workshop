+++
title = "環境ごとの設定を追加する"
weight = 100
+++

## 設定ファイルを実装する

`iac/lib/config.ts` を新規作成し、以下の内容にします。

```typescript
export interface EnvConfig {
  readonly memorySize: number;
}

const configs: Record<string, EnvConfig> = {
  dev: {
    memorySize: 256,
  },
};

export const getConfig = (env: string): EnvConfig => {
  const config = configs[env];
  if (!config) {
    throw new Error(`Unknown env: ${env}`);
  }
  return config;
};
```

## エントリポイントを実装する

`iac/bin/iac.ts` を、以下の内容で**全体を置き換えます**。

```typescript
#!/usr/bin/env node
import * as cdk from 'aws-cdk-lib/core';
import { IacStack } from '../lib/iac-stack';
import { getConfig } from '../lib/config';

const app = new cdk.App();
const env: string = app.node.tryGetContext('env') ?? 'dev';
const config = getConfig(env);

new IacStack(app, `IacStack-${env}`, { config });
```

スタック名は、これまでの `IacStack-dev` と同じ文字列になるように組み立てています。

## スタックを実装する

`iac/lib/iac-stack.ts` を、以下の内容で**全体を置き換えます**。

```typescript
import * as cdk from 'aws-cdk-lib/core';
import { Construct } from 'constructs';
import { NodejsFunction } from 'aws-cdk-lib/aws-lambda-nodejs';
import { Table, AttributeType, BillingMode } from 'aws-cdk-lib/aws-dynamodb';
import * as path from 'node:path';
import { EnvConfig } from './config';

export interface IacStackProps extends cdk.StackProps {
  readonly config: EnvConfig;
}

export class IacStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props: IacStackProps) {
    super(scope, id, props);

    const table = new Table(this, 'ItemTable', {
      partitionKey: { name: 'id', type: AttributeType.STRING },
      billingMode: BillingMode.PAY_PER_REQUEST,
    });

    const writeFunction = new NodejsFunction(this, 'WriteFunction', {
      entry: path.join(__dirname, '..', 'lambda', 'write.ts'),
      handler: 'handler',
      memorySize: props.config.memorySize,
      environment: {
        TABLE_NAME: table.tableName,
      },
    });

    table.grants.readWriteData(writeFunction);
  }
}
```

## 差分を確認する

`dev` の設定値は、これまでデプロイしてきた内容と同じなので、差分は出ません。

```bash
pnpm exec cdk diff -c env=dev
```
