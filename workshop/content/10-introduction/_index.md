+++
title = "はじめに"
chapter = true
weight = 10
+++

# はじめに

AWS CDK は、TypeScript などのプログラミング言語で AWS のインフラを定義できるツールです。

このワークショップでは、以下の構成を持つ CDK アプリを作ります。

- Lambda 関数
- DynamoDB テーブル
- Lambda から DynamoDB への書き込み権限（IAM）

最終的には、この構成を **dev** と **prod** の2つの環境にデプロイできる状態にします。
