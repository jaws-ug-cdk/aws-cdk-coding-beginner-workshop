+++
title = "合成（synth）する"
weight = 200
+++

## 手順

CDKのソースコードをCloudFormationテンプレートに合成します。
以下のコマンドをGitHub Codespacesのターミナルで実行してください。

```bash
pnpm exec cdk synth
```

合成されたテンプレートを開きます。

```bash
code "$(git rev-parse --show-toplevel)/iac/cdk.out/IacStack-dev.template.json"
```

テンプレートのLambda関数を見ると、CDKのコードで直接指定していない`Runtime`の設定も反映されています。
これは指定しなかった場合にAWSが推奨するランタイムを、CDKが自動的に設定してくれるためです。

```json
"Function76856677": {
  "Type": "AWS::Lambda::Function",
  "Properties": {
    "Code": {
      "S3Bucket": {
      "Fn::Sub": "cdk-hnb659fds-assets-${AWS::AccountId}-${AWS::Region}"
      },
      "S3Key": "<asset-hash>.zip"
    },
    "Handler": "index.handler",
    "Role": {
      "Fn::GetAtt": [
      "FunctionServiceRole675BB04A",
      "Arn"
      ]
    },
    "Runtime": "nodejs24.x"
    },
  },
  （略）
},
```
