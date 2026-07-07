+++
title = "AWS CDKとは"
weight = 200
+++

インフラリソースをコードで定義し、その定義ファイルをもとに構築する手法をIaC（Infrastructure as Code）と呼びます。
インフラリソースを管理するための状態管理の仕組みを持ち、管理対象とインフラ定義との間に差分があればインフラリソースを変更する仕組みになっています。

![whats iac](../images/10-introduction/whats-iac.dio.png)

AWS CDKはIaCを実現するツールの1つです。定義ファイルをTypeScriptなどの**プログラミング言語**で書けるのが特徴です。
AWSへデプロイすると「スタック」という単位で管理され、スタックによりリソースの状態が保持されます。

![whats cdk](../images/10-introduction/whats-cdk.dio.png)

AWS CDKの裏側ではAWS CloudFormationを利用しています。

CloudFormationはAWSリソースをJSON/YAMLファイルとして定義できるIaCサービスです。
CDKで書いたコードがCloudFormationテンプレートに変換され、そのテンプレートをCloudFormationがデプロイします。

CDKがCloudFormationを抽象化していることにより、少ないコード量で本質的なインフラの設定を表現できます。

![whats cdk in cfn](../images/10-introduction/whats-cdk-in-cfn.dio.png)
