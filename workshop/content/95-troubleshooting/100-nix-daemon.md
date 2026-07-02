+++
title = "aws・cdk・pnpmコマンドを実行したら「command not found」エラーになる"
weight = 100
+++

## 症状

Codespacesは一定時間操作がないと自動的に停止します。再接続後、以下のように `aws`・`cdk`・`pnpm` などのコマンドが「存在しない」ように見えることがあります。

```
$ pnpm exec cdk diff
command not found: pnpm
```

## 対処法

以下のコマンドを順番に実行してください。

```bash
sudo bash -c 'setsid nohup /nix/var/nix/profiles/default/bin/nix-daemon >/var/log/nix-daemon.log 2>&1 < /dev/null &'
direnv reload
```

これでコマンドが使えるようになります。
