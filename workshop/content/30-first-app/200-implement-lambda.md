+++
title = "Lambda関数を実装する"
weight = 200
+++

## パッケージを追加する

`iac` ディレクトリで、Lambda 関数をバンドルするために esbuild を追加します。

```bash
pnpm add -D esbuild
pnpm approve-builds --all
```

## Lambda関数を実装する

`iac/lambda/hello.ts` を新規作成し、以下の内容にします。

```typescript
export const handler = async (): Promise<{ statusCode: number; body: string }> => {
  return {
    statusCode: 200,
    body: 'Hello, CDK!',
  };
};
```

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
    });
  }
}
```
