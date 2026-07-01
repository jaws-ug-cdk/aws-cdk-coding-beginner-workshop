+++
title = "プロジェクトを作成する"
weight = 100
+++

## 手順

```bash
cd iac
npx cdk init app --language typescript --package-manager pnpm
```

`iac` ディレクトリの中に、以下のファイルが生成されます。

- `bin/iac.ts` … アプリのエントリポイント
- `lib/iac-stack.ts` … スタック定義（`IacStack` クラス）

生成直後は pnpm がビルドスクリプトの実行を保留しているので、承認します。

```bash
pnpm approve-builds --all
```

これ以降、`iac` ディレクトリ内では `pnpm exec cdk ...` で CDK コマンドを実行します。
