+++
title = "環境ごとの設定を追加する"
weight = 100
+++

## 設定ファイルを実装する

`iac/lib/config.ts` を開きます。GitHub Codespacesのターミナルで次のコマンドを実行します。

```bash
code "$(git rev-parse --show-toplevel)/iac/lib/config.ts"
```

以下の内容に書き換えます。

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

<!-- TODO: CDKのcontextとは何か、app.node.tryGetContext('env')と`-c env=dev`フラグの関係を説明する -->

## エントリポイントを実装する

`iac/bin/iac.ts` を開きます。ターミナルで次のコマンドを実行します。

```bash
code "$(git rev-parse --show-toplevel)/iac/bin/iac.ts"
```

以下の内容に**全体を書き換えます**。

```typescript {hl_lines=["4","9-10","12"]}
#!/usr/bin/env node
import * as cdk from 'aws-cdk-lib/core';
import { IacStack } from '../lib/iac-stack';
import { getConfig } from '../lib/config';

const app = new cdk.App();
/**
 * スタック削除時のポリシーを「リソースを削除する」に設定する。
 * DynamoDB などのステートフルなリソースはデフォルトで「リソースを保持する」
 * ポリシーになっているため、スタックを削除してもリソースが残り続ける。
 * ワークショップではリソースの後片付けを簡単にするため、一括で削除する設定にしている。
 */
cdk.RemovalPolicies.of(app).destroy();

const env: string = app.node.tryGetContext('env') ?? 'dev';
const config = getConfig(env);

new IacStack(app, `IacStack-${env}`, { config });
```

スタック名は、これまでの `IacStack-dev` と同じ文字列になるように組み立てています。

## スタックを実装する

`iac/lib/iac-stack.ts` を開きます。ターミナルで次のコマンドを実行します。

```bash
code "$(git rev-parse --show-toplevel)/iac/lib/iac-stack.ts"
```

以下の内容に**全体を書き換えます**。

```typescript {hl_lines=["6","8-10","13","24"]}
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

    const writeFunction = new NodejsFunction(this, 'Function', {
      entry: path.join(__dirname, '..', 'lambda', 'write.ts'),
      handler: 'handler',
      memorySize: props.config.memorySize,
      environment: {
        TABLE_NAME: table.tableName,
      },
    });

    table.grants.writeData(writeFunction);
  }
}
```

## 差分を確認する

開発環境の設定値はこれまでデプロイしてきた内容と同じなので、差分は出ません。

```bash
pnpm exec cdk diff -c env=dev
```

以下のように表示されます。

```
Stack IacStack-dev
There were no differences

✨  Number of stacks with differences: 0
```

差分が無いということはデプロイ内容に変更が無いということなので、ここでの`cdk deploy`は不要です。
