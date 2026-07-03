---
title: "AWS CDK Coding Beginner Workshop"
chapter: true
weight: 1
---

# Welcome!

AWS CDK を初めて学ぶ人向けのハンズオンです。Lambda 関数と DynamoDB テーブルを持つ CDK アプリを作りながら、複数環境（dev / prod）へのデプロイまで一通り体験します。

## 必要なもの

- GitHub アカウント
- AWS アカウント（`AdministratorAccess`相当の権限が必要です）

{{% notice tip %}}
手順の途中で何か詰まったら、付録の[トラブルシューティング]({{< ref "/95-troubleshooting" >}})を確認してください。
{{% /notice %}}

{{% notice tip %}}
コマンドやコードは手入力せず、すべてコピー&ペーストで進めてください。
{{% /notice %}}

このワークショップを終えると、次のことができるようになります。

- CDK アプリを新規作成し、AWS へデプロイする
- リソースを追加・変更し、`cdk diff` で差分を確認してからデプロイする
- IAM 権限（Grants）を適切に付与する
- `context` を使って環境（dev / prod）ごとに異なる設定でデプロイする

## このワークショップの構成

左メニューの章立てに沿って進めます（番号の昇順）。

1. はじめに
2. 環境準備
3. 最初のアプリを作る
4. アプリを更新する
5. 複数環境にデプロイする
6. 後片付け
7. まとめ

「トラブルシューティング」は付録なので、上の番号には含まれません。困ったときに参照してください。

## See Also

- [AWS CDK Developer Guide](https://docs.aws.amazon.com/cdk/v2/guide/)
- [AWS CDK API Reference](https://docs.aws.amazon.com/cdk/api/v2/)
- [Construct Hub](https://constructs.dev/)

{{% notice note %}}
**免責・帰属**: 本資料は [AWS CDK Workshop](https://cdkworkshop.com/) のフォーマットを基に
JAWS-UG CDK 支部のメンバーが作成したものです。本資料は AWS による公認・後援・提携を示すものではありません。
AWS、Amazon、AWS CDK などは Amazon.com, Inc. またはその関連会社の商標です。
{{% /notice %}}
