+++
title = "AWS CDKとは"
weight = 200
+++

インフラリソースをコードで定義し、その定義ファイルをもとに構築する手法を、IaC（Infrastructure as Code）と呼びます。「リソースの状態」を管理し、定義ファイルとの差分を検出して変更点だけを反映するという仕組みです。

![whats iac](../images/10-introduction/whats-iac.dio.png)

AWS CDKは、IaCを実現するツールの1つで、定義ファイルをTypeScriptなどの**プログラミング言語**で書けるのが特徴です。
AWSへデプロイすると「スタック」という単位で管理され、スタックによりリソースの状態が保持されます。

![whats cdk](../images/10-introduction/whats-cdk.dio.png)

AWS CDKは裏側でAWS CloudFormationを利用しています。

CloudFormationはAWSリソースをJSON/YAMLファイルとして定義できるIaCサービスです。
CDKで書いたコードがCloudFormationテンプレートに変換され、そのテンプレートをCloudFormationがデプロイします。

CDKがCloudFormationを抽象化していることにより、少ないコード量で本質的なインフラの設定を表現できます。

![whats cdk in cfn](../images/10-introduction/whats-cdk-in-cfn.dio.png)
