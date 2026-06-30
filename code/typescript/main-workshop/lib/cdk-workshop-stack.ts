import * as cdk from "aws-cdk-lib";
import { Construct } from "constructs";

// ワークショップ本編のスタック定義（スケルトン）。
// TODO: 各章で追加するリソース（Lambda / API Gateway / DynamoDB など）をここに実装する。
export class CdkWorkshopStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // TODO: ここにリソースを定義する
  }
}
