+++
title = "prod環境を追加する"
weight = 200
+++

## 設定ファイルを更新する

`iac/lib/config.ts` を、以下の内容で**全体を置き換えます**。

```typescript
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
