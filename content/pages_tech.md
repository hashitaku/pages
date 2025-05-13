---
title: このサイトを支える技術
---

https://github.com/hashitaku/pages

- Quartz 4
- Git
- GitHub
- Cloudflare Pages
- Cloufflare Cache
- Cloudflare R2

## Quartz 4

Obsidianのような見た目なSSG

ObsidianとQuartzの関係はわかってない

できることは公式ドキュメント参照

https://quartz.jzhao.xyz/

## Git

Quartzのコードと記事自体を管理

GitHubにあるQuartzをテンプレートとして使用することも可能であるが現在は`git subtree`で管理している

```
.
├── .git/
├── .gitignore
├── LICENSE
├── README.md
├── content/
└── quartz/
```

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

## GitHub

コードホスティング先

`Cloudflare Workers and Pages`を使用して後述するCloudflare Pagesにデプロイしている

https://github.com/apps/cloudflare-workers-and-pages

## Cloudflare Pages

言わずと知れたホスティングサービス

もしかしたらCloudflare Workersに乗り換えるかも

デプロイの設定は以下の通り

- ビルドコマンド: `npx quartz build`
- ビルド出力: `public`
- ルートディレクトリ: `quartz`

## Cloudflare Cache

[Default Cache Behavior](https://developers.cloudflare.com/cache/concepts/default-cache-behavior/)

Pagesをキャッシュさせる為に使用している

デフォルトではHTMLはキャッシュされないのでCache Rulesを設定する必要がある

![cloudflare_r2_pricing](https://r2.hashitaku.dev/cloudflare_cache_pages.png)

## Cloudflare R2

AWS S3互換のクラウドストレージ

エグレス料金が無料

クラスA/B操作として状態の変更と読み取りにそれぞれ料金が設定されている

2025年5月現在は以下の通り(以下の画像もR2に置かれてる)

![cloudflare_r2_pricing](https://r2.hashitaku.dev/cloudflare_r2_pricing.png)

月々のクラスA/B操作がどれぐらいになるのか想像がつかないのでCloudflareの通知設定で50万/500万回を超過したらメールが来るようにしている

![cloudflare_r2_notification](https://r2.hashitaku.dev/cloudflare_r2_notification.png)
