+++
title = "プロパティを変更する"
weight = 100
+++

## スタックを実装する

`iac/lib/iac-stack.ts` を、以下の内容で**全体を置き換えます**。

```typescript
import * as cdk from 'aws-cdk-lib/core';
import { Construct } from 'constructs';
import { NodejsFunction } from 'aws-cdk-lib/aws-lambda-nodejs';
import * as path from 'node:path';

export class IacStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    new NodejsFunction(this, 'HelloFunction', {
      entry: path.join(__dirname, '..', 'lambda', 'hello.ts'),
      handler: 'handler',
      memorySize: 256,
    });
  }
}
```

## 差分を確認する

`iac` ディレクトリで実行します。

```bash
pnpm exec cdk diff
```

## デプロイする

```bash
pnpm exec cdk deploy
```
