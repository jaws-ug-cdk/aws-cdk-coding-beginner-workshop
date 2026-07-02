+++
title = "Lambda関数を実装する"
weight = 100
+++

## Lambda関数を実装する

`iac/lambda/hello.ts` を開きます。

```bash
code "$(git rev-parse --show-toplevel)/iac/lambda/hello.ts"
```

以下の内容に書き換えます。

```typescript
export const handler = async (): Promise<{ statusCode: number; body: string }> => {
  return {
    statusCode: 200,
    body: 'Hello, CDK!',
  };
};
```

<!-- TODO: Constructとは何か、scope(this)/id/propsの考え方、NodejsFunctionのentry/handlerの意味を説明する -->

## スタックを実装する

`iac/lib/iac-stack.ts` を開きます。

```bash
code "$(git rev-parse --show-toplevel)/iac/lib/iac-stack.ts"
```

以下の内容に**全体を書き換えます**。

```typescript
import * as cdk from 'aws-cdk-lib/core';
import { Construct } from 'constructs';
import { NodejsFunction } from 'aws-cdk-lib/aws-lambda-nodejs';
import * as path from 'node:path';

export class IacStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    new NodejsFunction(this, 'Function', {
      entry: path.join(__dirname, '..', 'lambda', 'hello.ts'),
      handler: 'handler',
    });
  }
}
```

<!-- TODO: App/Stackとは何か、スタックがCloudFormationのデプロイ単位であることを説明する -->

## エントリポイントを実装する

`iac/bin/iac.ts` を開きます。

```bash
code "$(git rev-parse --show-toplevel)/iac/bin/iac.ts"
```

以下の内容に**全体を書き換えます**。スタック名に `dev` を含めておきます。

```typescript
#!/usr/bin/env node
import * as cdk from 'aws-cdk-lib/core';
import { IacStack } from '../lib/iac-stack';

const app = new cdk.App();
cdk.RemovalPolicies.of(app).destroy();

new IacStack(app, 'IacStack-dev');
```
