---
title: 文書を書く環境
draft: true
date: 2025-05-16
---

プライベートや仕事でメモ・議事録・ドキュメントを作成する際は主にmarkdownを使用しています。

組版が必要な文書を書く際はWordを使っていましたが最近はtypstに置き換えつつあります。

文書を書く機会はとても多いので自分の文書を書く環境を紹介します。

# markdown

基本的にmarkdownで書いた文書はgitで管理しています。

複数のデバイスで閲覧する必要があり履歴を気にしない文書に関してはJoplinを使用してDropboxで同期しています。

AIとの連携については全くついていけていないのでAIの面からの言及はないです。

## VSCode

拡張機能でノートアプリに生まれ変わらせることも可能ですがあくまでテキストエディタなので[Markdown Preview Enhanced](https://shd101wyy.github.io/markdown-preview-enhanced)をインストールするのみにとどめています。

MermaidやGraphVizなどもレンダリングできるようになるので重宝しています。

GitHubやObsidianにあるCalloutsが使用できないのが玉に瑕です。

他にも便利な拡張機能はありそうですが情報が収集できていません。

> [!TIP] Tips
> QuartzはCalloutsが使用できます

## NeoVim

VSCodeに[VSCode Neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim)をインストールして使用していますが完全にVim/NeoVimを再現できているわけではないのでNeoVimで文書を書くことが多いです。

NeoVimでmarkdownを書く際にライブプレビューができないのが難点でしたが[OXY2DEV/markview.nvim](https://github.com/OXY2DEV/markview.nvim)を導入してから困ることはほとんどなくなりました。

SixelやKitty Text Sizing Protocolなどがあればリッチな描画も可能になると思うので技術の発展に期待です。

## Joplin

記法はmarkdownですが自分はVSCodeやNeoVimで文章を書くときと全く異なる使い方をしています。

スマホでも簡単に同期ができるので出先でさっとメモしたいことなどがあればJoplinを使用しています。

Joplinのアプリ内に同期機能が備わっていてバックエンドもDropbox, OneDrive, S3, Nextcloud, WebDAVから選べるので困ることはないと思います。

有料プランに加入すると同期やPublishが使用できますが無料プランでも全く困らないと思います。

たまに、同期の調子が悪くコンフリクトすることがあるので何か書き始めるときは同期ボタンをしっかり押してから使うようにはしています。

もしかしたら有料プランでは全くそんなことが発生しないのかもしれないです。

月額500円ぐらいで試すこともできるので一度試してみてもいいかもしれないです。

PCで使用する際も基本的に困ることはないですがArchLinuxにインストールする時にAURしかないのが困っています。

## Obsidian

Joplinと比べて機能面での優劣はあまり感じていませんがUIがだいぶ洗練されている印象はあります。

同期を外部のストレージサービスと行いたいと思うとプラグインの導入が必須になります。

有料ですが公式の同期機能もあります。

Obsidianは以前まで商用利用する場合はライセンス契約が必要だったのですが最近、商用利用でも無料で使用できるようになったそうです。

会社でも何度か使用してみましたがNeoVimでメモを取るほうが早いのでやめてしまいました。

プライベートでの使用を最近試しているところですが自分の用途ではJoplinで足りているので移行することは現状なさそうです。
