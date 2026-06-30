#!/usr/bin/env node
// CDK アプリのエントリポイント（スケルトン）。
// TODO: ワークショップで作成するスタックをここで生成する。
import * as cdk from "aws-cdk-lib";
import { CdkWorkshopStack } from "../lib/cdk-workshop-stack";

const app = new cdk.App();
new CdkWorkshopStack(app, "CdkWorkshopStack");
