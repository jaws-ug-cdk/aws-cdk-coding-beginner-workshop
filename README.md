# AWS CDK Coding Beginner Workshop

AWS CDKを初めて学ぶ人向けのワークショップリポジトリです。

## Developer Guide

このワークショップは [hugo](http://gohugo.io) で markdown を静的 HTML サイトとしてビルドします。
開発環境は [Nix](https://nixos.org/) で再現します。

```bash
# 未導入なら Nix をインストール
$ curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install

# 開発環境に入る
$ nix develop
```

> [!NOTE]
> Nix を使わない場合は、以下の手順で hugo をインストールします。
>
> ```bash
> brew install hugo
> ```

ワークショップの内容は [workshop/](workshop/) ディレクトリにあります。
ローカル開発サーバは次のように起動します。

```bash
$ hugo server -D --source workshop
$ open http://localhost:1313/
```

## Deploy

`main` への push で [GitHub Actions](.github/workflows/gh-pages.yml) が GitHub Pages へ公開します。

## License Summary

This project is released under the MIT License. See the [LICENSE](./LICENSE) file.
本資料は [AWS CDK Workshop](https://cdkworkshop.com/) を基にしています（[LICENSE](./LICENSE) に帰属を記載）。
同梱テーマ [hugo-theme-learn](https://github.com/matcornic/hugo-theme-learn) は MIT ライセンス（`workshop/themes/learn/LICENSE.md`）です。
