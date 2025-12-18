---
title: このサイトを支える技術
date: 2025-07-11
description:
tags:
  - Quartz
  - Cloudflare
  - Git
---

https://github.com/hashitaku/pages

- Quartz 4
- Git
- GitHub
- Cloudflare Workers
- Cloudflare Cache
- Cloudflare R2

## Quartz 4

Obsidianのような見た目なSSG

ObsidianとQuartzの関係はわかってない

できることは[公式ドキュメント](https://quartz.jzhao.xyz)参照

テーマに[saberzero1/quartz-themes](https://github.com/saberzero1/quartz-themes)を使用

## Git

Quartzのコードと記事自体を管理

GitHubにあるQuartzをテンプレートとして使用することも可能であるが、記事自体の管理とQuartzの管理は疎結合にしたいので`git subtree`で管理している

```
.
├── .git/
├── .github/
├── .gitignore
├── LICENSE
├── Makefile          // タスクランナー用
├── README.md
├── content/          // 記事の保管場所
├── package-lock.json
├── package.json      // Wrangler用
├── quartz/           // Quartz本体
└── wrangler.toml
```

プロジェクト作成時は以下のコマンドで作成した

```sh
# Quartzをリモートリポジトリとして追加
git remote add quartz https://github.com/jackyzha0/quartz.git

# サブツリーを作成
git subtree add --prefix quartz/ --squash quartz v4

# contentをシンボリックリンクにする
cd quartz && git rm -r content && ln -s ../content content && cd ..

# Quartzをアップデート
git subtree pull --prefix quartz/ --squash quartz v4
```

プレビューやQuartzのアップデート時は`Makefile`に`.PHONY`ターゲットとしてタスクを登録しているのでそれを実行している

本当は`wranger dev`や`npm run dev`でローカルサーバーを実行したいがホットリロードができないので`quartz build --serve --watch`でローカルサーバーを建てている

`quartz build --watch --output ../public`で変更時のビルドのみはQuartzに行ってもらいサーバーの実行はWranglerに任せることもできそうだけど断念

## GitHub

コードホスティング先

GitHub Actionsを使用してCloudflare Workersにデプロイしている

デプロイ時に[saberzero1/quartz-themes](https://github.com/saberzero1/quartz-themes)のテーマも当てている

## Cloudflare Workers

サーバーレスの実行環境

以前までCloudflare Pagesに置いていたがCloudflare WorkersのStatic Assetsへ移動した

## Cloudflare Cache

Pagesをキャッシュさせる為に使用している

[デフォルトではHTMLはキャッシュされない](https://developers.cloudflare.com/cache/concepts/default-cache-behavior/)のでCache Rulesを設定する必要がある

![cloudflare_cache_pages](https://r2.hashitaku.dev/cloudflare_cache_pages.png)

## Cloudflare R2

AWS S3互換のクラウドストレージ

エグレス料金が無料

クラスA/B操作として状態の変更と読み取りにそれぞれ料金が設定されている

2025年5月現在は以下の通り(以下の画像もR2に置かれてる)

![cloudflare_r2_pricing](https://r2.hashitaku.dev/cloudflare_r2_pricing.png)

月々のクラスA/B操作がどれぐらいになるのか想像がつかないのでCloudflareの通知設定で50万/500万回を超過したらメールが来るようにしている

![cloudflare_r2_notification](https://r2.hashitaku.dev/cloudflare_r2_notification.png)
