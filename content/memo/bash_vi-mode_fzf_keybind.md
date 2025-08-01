---
title: Bashをviモードで使う際のfzfキーバインド
description:
date: 2025-07-31
draft: true
---

## Bash(readline)のviモード

自分はBashをviモードで使用しています。

```readline
set editing-mode vi
set show-mode-in-prompt on
set vi-cmd-mode-string "\1\e[2 q\2"
set vi-ins-mode-string "\1\e[6 q\2"

$if mode=vi
    set keymap vi-insert
        Control-l: clear-screen
$endif
```

テキストオブジェクトなど使用できない機能はたくさんありますが`cc`での行削除や`jk`での履歴移動はとても便利です。

カーソルの形状で自分がどのモードにいるかも判別できます。

![demo_vi-mode.gif](https://r2.hashitaku.dev/demo_vi-mode.gif)

## fzf

`jk`での履歴移動は便利ですが履歴を検索したいこともあります。

`readline`の`reverse-search-history`で履歴検索をすることも可能ですがリッチなUIがほしいのと、あいまい検索ができるため`fzf`を使用しています。

`.bashrc`の中で`fzf`のセットアップを行っています。

```bash
type fzf >/dev/null 2>&1 && eval "$(fzf --bash)"
```

`fzf --bash`を読み込むことでいくつかのキーバインドと関数が追加されます。

## 意図しないタイミングで`__fzf_cd__`が起動してしまう現象が発生

`echo Hello World`と入力後に`Ctrl-[`でノーマルモードへ移動、`cc`で行を削除を行うつもりが`__fzf_cd__`が起動してしまいます。

`cc`の`c`を入力した時点で`__fzf_cd__`が起動し検索欄に`c`が入力されます。

![normal_fzf-cd.gif](https://r2.hashitaku.dev/normal_fzf-cd.gif)

上のgifを生成した`vhs`

```vhs
Output demo.gif

Require echo
Require fzf

Set Shell "bash"
Set FontSize 32
Set Width 800
Set Height 600
Set TypingSpeed 50ms

Hide
Type `eval "$(fzf --bash)"`
Enter
Show

Type "echo Hello World"

Sleep 1s

Ctrl+[
Sleep 100ms
Type "cc"

Sleep 3s
```

`Ctrl+[`の直後にある`Sleep 100ms`を`500ms`以上にすると想定した動作になります。

![normal_cc.gif](https://r2.hashitaku.dev/normal_cc.gif)

## 原因

`fzf --bash`を読み込んで追加されるキーバインドの一つに`Alt-c`で`__fzf_cd__`を呼び出すものがあります。

```readline
bind -m emacs-standard '"\ec": " \C-b\C-k \C-u`__fzf_cd__`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
bind -m vi-command '"\ec": "\C-z\ec\C-z"'
bind -m vi-insert '"\ec": "\C-z\ec\C-z"'
```

`Alt-c`は
