---
title: Quartz4のOGPを設定した
date: 2025-12-18
description: ""
tags:
  - Quartz
---

Quartz4ではSNSなどに共有した際にOGPを使用してカード表示が行えます。

## 概要の表示

デフォルトでは記事の文頭が入った画像が生成されます。

<div style="
    width: 50%;
    filter: drop-shadow(2px 2px 4px #000000);
    margin: 0 auto;
">
    <img src="https://r2.hashitaku.dev/quartz_ogp_og-image_default.webp">
</div>

記事のmarkdownにFront Matterを作成し`description`キーを記載すると以下のようになります。

<div style="
    width: 50%;
    filter: drop-shadow(2px 2px 4px #000000);
    margin: 0 auto;
">
    <img src="https://r2.hashitaku.dev/quartz_ogp_og-image_description.webp">
</div>

`description`を空文字列にすることもできます。

## 記事タイトルの編集

記事タイトルにサイトの[`pageTitleSuffix`](https://quartz.jzhao.xyz/configuration#general-configuration)を付けたくなかったのでQuartz側を直接修正しました。

<script src="https://emgithub.com/embed-v2.js?target=https%3A%2F%2Fgithub.com%2Fjackyzha0%2Fquartz%2Fblob%2F9c042dd7178c32a3c44ba59ad2252d39e877745c%2Fquartz%2Fplugins%2Femitters%2FogImage.tsx%23L74-L82&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showFullPath=on&showCopy=on"></script>

```diff
diff --git a/quartz/quartz/plugins/emitters/ogImage.tsx b/quartz/quartz/plugins/emitters/ogImage.tsx
index 813d934..68875d3 100644
--- a/quartz/quartz/plugins/emitters/ogImage.tsx
+++ b/quartz/quartz/plugins/emitters/ogImage.tsx
@@ -73,9 +73,8 @@ async function processOgImage(
 ) {
   const cfg = ctx.cfg.configuration
   const slug = fileData.slug!
-  const titleSuffix = cfg.pageTitleSuffix ?? ""
   const title =
-    (fileData.frontmatter?.title ?? i18n(cfg.locale).propertyDefaults.title) + titleSuffix
+    (fileData.frontmatter?.title ?? i18n(cfg.locale).propertyDefaults.title)
   const description =
     fileData.frontmatter?.socialDescription ??
     fileData.frontmatter?.description ??
```

<div style="
    width: 50%;
    filter: drop-shadow(2px 2px 4px #000000);
    margin: 0 auto;
">
    <img src="https://r2.hashitaku.dev/quartz_ogp_og-image_title.webp">
</div>

## アイコン画像の調整

`quartz/static/icon.png`にある画像がOG画像の左上にアイコンとして表示されます。

画像サイズによっては見切れることがあるためQuartz側を修正しました。

<script src="https://emgithub.com/embed-v2.js?target=https%3A%2F%2Fgithub.com%2Fjackyzha0%2Fquartz%2Fblob%2F9c042dd7178c32a3c44ba59ad2252d39e877745c%2Fquartz%2Futil%2Fog.tsx%23L222-L231&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showFullPath=on&showCopy=on"></script>

```diff
diff --git a/quartz/quartz/util/og.tsx b/quartz/quartz/util/og.tsx
index 2afd606..ac64951 100644
--- a/quartz/quartz/util/og.tsx
+++ b/quartz/quartz/util/og.tsx
@@ -220,14 +220,26 @@ export const defaultImage: SocialImageOptions["imageStructure"] = ({
         }}
       >
         {iconBase64 && (
-          <img
-            src={iconBase64}
-            width={56}
-            height={56}
+          <div 
             style={{
-              borderRadius: "50%",
+                display: "flex",
+                alignItems: "center",
+                justifyContent: "center",
+                width: 56,
+                height: 56,
+                borderRadius: "50%",
+                overflow: "hidden",
             }}
-          />
+          >
+            <img
+              src={iconBase64}
+              style={{
+                width: "90%",
+                height: "90%",
+                objectFit: "contain",
+              }}
+            />
+          </div>
         )}
         <div
           style={{
```

最終的に以下のような形にしました。

<div style="
    width: 50%;
    filter: drop-shadow(2px 2px 4px #000000);
    margin: 0 auto;
">
    <img src="https://r2.hashitaku.dev/quartz_ogp_og-image_icon.webp">
</div>
