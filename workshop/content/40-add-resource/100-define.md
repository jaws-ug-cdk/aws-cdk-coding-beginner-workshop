+++
title = "リソースを定義する"
weight = 100
+++

## このページについて

このページはサンプルです。スタックにリソースを追加するコードと、その解説を書きます。

差分を強調したいときは、コードフェンスに `hl_lines` を付けてハイライトできます。

```typescript {hl_lines=["6-9"]}
import * as cdk from "aws-cdk-lib";
import { Construct } from "constructs";

export class CdkWorkshopStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // TODO: ここに追加するリソースを定義する
    // 例: new lambda.Function(this, "Hello", { ... });
  }
}
```

{{% notice info %}}
コードハイライトは、変更箇所だけを強調することで初学者がどこを編集したか分かりやすくなります。
このリポジトリは元ワークショップ（aws-cdk-intro-workshop）の慣習を踏襲しています。
{{% /notice %}}
