# LaTeX 作業模板

一份支援繁體中文、作業導向的 $\LaTeX$ 模板。修改自 https://github.com/gijs-pennings/latex-homework 。

## 功能

除了 $\LaTeX$ 的基本功能外，還包含/引入了：

- 用 `*` 代替 `\cdot` 、一些常用的其他符號（如高斯符號、集合）。
- `\problem` ：作業習題標題。
- `\Code` ：漂亮的 C/C++ 程式塊。

……等等功能，有興趣可以翻翻 `homework.cls` 裡面所引入的 package 。

## 使用方式

- `template.tex` 是一個空的檔案，可以複製當模板使用。
- 範例請見 `main.pdf` 和 `main.tex` 。
- 可以將 `homework.cls` 放到與主要的 `.tex` 檔案同一個資料夾，或是將其放在 `~/texmf/tex/latex/local` 底下（沒有這個目錄可以自己建立）。
- 請使用 `pdflatex` 或 `latexmk` 並加上 `-pdfxe -shell-escape` 編譯。
