+++
title = "プロパティを変更する"
weight = 100
+++

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

```bash
pnpm exec cdk deploy
```

## 確認

AWS マネジメントコンソールの画面上部の検索窓に`CloudFormation`と入力し、表示された`CloudFormation`を選択します。`IacStack-dev`スタックを開き、「リソース」タブで`Function`を展開して`AWS::Lambda::Function`の物理IDリンクをクリックし、Lambda関数のページに移動します。

![lambda function page](../images/40-add-resource/lambda-function-page.png)

「設定」タブを開き、メモリが`256 MB`に変更されていることを確認します。

![lambda memory size](../images/40-add-resource/lambda-memory-size.png)
