+++
title = "プロパティを変更する"
weight = 100
+++

## スタックを実装する

`iac/lib/iac-stack.ts` を開きます。GitHub Codespacesのターミナルで次のコマンドを実行します。

```bash
code "$(git rev-parse --show-toplevel)/iac/lib/iac-stack.ts"
```

以下の内容に**全体を書き換えます**。

```typescript {hl_lines=["13"]}
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
      memorySize: 256,
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
Stack IacStack-dev
Resources
[~] AWS::Lambda::Function Function Function76856677
 └─ [+] MemorySize
     └─ 256
```

- `[~]` … このリソースが**変更**されることを表します
- `[+]` … `MemorySize` プロパティが**新規追加**されることを表します

リソースの置き換え（削除して作り直し）を伴わない、プロパティの更新のみであることが分かります。

## デプロイする

次のコマンドをターミナルで実行します。

```bash
pnpm exec cdk deploy
```

## 確認

先ほど開いたLambda関数を再度開きます。

![lambda function page](../images/40-add-resource/lambda-function-page.png)

「設定」タブを開き、メモリが`256 MB`に変更されていることを確認します。

{{% notice note %}}
メモリの設定が`128 MB`のままであれば、画面を再読み込みした上で再度確認してください。
{{% /notice %}}


![lambda memory size](../images/40-add-resource/lambda-memory-size.png)
