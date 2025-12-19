---
title: Quartz4のOGPを設定した
date: 2025-12-18
description: ""
tags:
  - Quartz
draft: true
---

Quartz4ではSNSなどに共有した際にOGPを使用してカード表示が行えます。

## 概要の表示

デフォルトでは記事の文頭が入った画像が生成されます。

![quartz_ogp_og-image_default.webp](https://r2.hashitaku.dev/quartz_ogp_og-image_default.webp)

記事のmarkdownにFront Matterを作成し`description`キーを記載すると以下のようになります。

![quartz_ogp_og-image_description.webp](https://r2.hashitaku.dev/quartz_ogp_og-image_description.webp)

`description`を空文字列にすることもできます。

## 記事名の編集


