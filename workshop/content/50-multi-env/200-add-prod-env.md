+++
title = "prod環境を追加する"
weight = 200
+++

## 設定ファイルを更新する

`iac/lib/config.ts` を開きます。

```bash
code "$(git rev-parse --show-toplevel)/iac/lib/config.ts"
```

以下の内容に**全体を書き換えます**。

```typescript {hl_lines=["9-11"]}
export interface EnvConfig {
  readonly memorySize: number;
}

const configs: Record<string, EnvConfig> = {
  dev: {
    memorySize: 256,
  },
  prod: {
    memorySize: 512,
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

## 合成する

```bash
pnpm exec cdk synth -c env=prod
```

## デプロイする

```bash
pnpm exec cdk deploy -c env=prod
```

`IacStack-prod`は初回デプロイなので、[最初のアプリを作る]({{< ref "/30-first-app/300-deploy" >}})の時と同じくIAM変更の確認が表示されます。`y`を入力してデプロイを続行します。

```
Do you wish to deploy these changes? (y/n) y
```

## 確認

AWS マネジメントコンソールの画面上部の検索窓に`CloudFormation`と入力し、表示された`CloudFormation`を選択します。`IacStack-dev`とは別に`IacStack-prod`スタックが`CREATE_COMPLETE`で作成されていることを確認します。

![prod stacks list](../images/50-multi-env/prod-stacks-list.png)

`IacStack-prod`スタックを開きます。「リソース」タブで`Function`を展開し、`AWS::Lambda::Function`の物理IDリンクをクリックしてLambda関数のページに移動します。

![prod stack resources](../images/50-multi-env/prod-stack-resources.png)

「設定」タブを開き、メモリが`512 MB`になっていることを確認します。`dev`環境の`256 MB`とは異なる値です。

![prod memory size](../images/50-multi-env/prod-memory-size.png)

同じ`iac-stack.ts`から、環境ごとに異なる設定でスタックをデプロイできることが確認できました。

## See Also

- [CDKでStage/環境ごとに動的にStackを生成するパターン](https://go-to-k.hatenablog.com/entry/cdk-stage-and-dynamic-static-stack)
