Hardware-accelerated Reversi Board Detection on PYNQ Platform
=============================================================

For English description, please refer to <a href="README.en.md">README.en.md</a>.

概要
----

このリポジトリでは，以下の論文で実装・評価されたリバーシ盤面認識回路と，
PYNQ-Z1 で動作するデモシステムを収録しています．

> Naoki Fujieda and Naoya Ito: A case for edge video processing with FPGA
> SoC: reversi board detection using Hough transform, 12th International
> Workshop on Computer Systems and Architectures (CSA-12) held in
> conjunction with CANDAR '24, pp. 50-55 (11/2024).

論文中での実装・評価は，以下の環境で行われています．
- Vitis HLS 2021.1
- Vitis video library 2021.1
- Vivado 2020.2
- PYNQ 2.6

また，以下の環境でも動作を確認しています．
- Vitis HLS 2022.1
- Vitis video library 2024.2
- Vivado 2022.1
- PYNQ 3.0.1

残念ながら，PYNQ 2.7 では正しく動作しないことを確認しています．
PYNQ 2.7 には，解放したバッファを再利用しないバグがあります．そのため，
どこかでメモリを確保できなくなり動作が停止します．

------------------------------------------------------------------------

リポジトリの構成
----------------

リポジトリのフォルダ構成は以下のとおりです．

- `C_src`: リバーシ盤検出回路の C++ ソースコード
  - `hough_only`: ハフ変換部分のみを高位合成する版
- `ip_repo`: 使用する IP コア一式（検出回路を高位合成したものを含む）
- `Jupyter_demo`: 動作デモ用の Jupyter Notebook
- `Jupyter_eval`: 性能評価用の Jupyter Notebook
- `overlay`: 論理合成済のハードウェアオーバーレイ
  - `2020_2`: Vivado 2020.2 を使用したもの
  - `2022_1`: Vivado 2022.1 を使用したもの
- `vivado`: ブロック図作成用のスクリプトと制約（xdc）ファイル

------------------------------------------------------------------------

使い方
------

### 下準備
#### OpenCV

Vitis Vision library を使ったコードを Vitis HLS で C Simulation するには，
OpenCV 4.4.0 が必要です．以下の手順でインストールします．
以下，ホームディレクトリの `vision/opencv-lib` にインストールする場合の
手順を示します．`USERNAME` は各自のユーザ名に置き換えてください．
`vision` フォルダをまだ作っていない場合は，作成してください．

>     $ cd
>     $ cd vision
>     $ git clone --depth=1 -b 4.4.0 https://github.com/opencv/opencv.git
>     $ cd opencv
>     $ mkdir build; cd build
>     $ cmake -D WITH_IPP=OFF -D CMAKE_INSTALL_PREFIX=/home/USERNAME/vision/opencv-lib ..

その後，ライブラリが実行時にロードされるように，LD_LIBRARY_PATH 環境変数
を修正します．以下は bash の場合です．シェルを起動してから Vitis HLS を実行
する前に毎回行うか，~/.bashrc に追加してください．

>     $ export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/USERNAME/vision/opencv-lib

#### Vitis Vision library

ライブラリのソースをダウンロードします．以下，ホームディレクトリの
`vision/vitis_vision` 以下に，バージョン 2021.1 のライブラリをダウンロード
する場合の手順を示します．

>     $ cd 
>     $ cd vision
>     $ git clone --depth=1 -b 2021.1 --no-checkout https://github.com/Xilinx/Vitis_Libraries.git
>     $ cd Vitis_Libraries
>     $ git sparse-checkout set vision
>     $ cd ..
>     $ mv Vitis_Libraries/vision vitis_vision
>     $ rm -rf Vitis_Libraries

#### プロジェクト作成時の注意事項

Vitis HLS 2021.1 以降には，CFLAGS における相対参照にバグがあります．
プロジェクトの設定で，ファイルのインクルード・リンクパスを以下の通りに
指定する必要があります．しかし GUI でこの設定を行うと，絶対パスが誤った
相対パスに変換され，必要なファイルを見つけることができなくなります．

- Project Settings -> Simulation -> CFLAGS
>     -I/home/USERNAME/vision/vitis_vision/L1/include -I/home/USERNAME/vision/opencv-lib/include/opencv4 -std=c++14 -Wno-unknown-pragmas
- Project Settings -> Simulation -> Linker Flags
>     -L /home/USERNAME/vision/opencv-lib/lib -lopencv_core -lopencv_imgcodecs -lopencv_imgproc
- Project Settings -> Synthesis -> CFLAGS (for .cpp file only)
>     -I/home/USERNAME/vision/vitis_vision/L1/include -std=c++14

考えられる Workaround は2つです．
- プロジェクトを Vitis HLS 2020.2 で作成し，上記の設定をしてから，
  2021.1 以降で開き直す
- Vitis HLS 2021.1 以降で上記の設定をしてから，一旦 Vitis HLS を終了し，
  hls.app をテキストエディタで編集する（絶対パスを指定し直す）

### 高位合成

盤検出回路を高位合成する場合は，`C_src` フォルダのファイルを使います．
Vitis HLS のプロジェクトを作成します．`reversi_accel.cpp` および `.hpp`
の2つのファイルを Design Files として，`reversi_accel_tb.cpp` と
`hough_software.hpp` を Testbench File として，それぞれ指定します．高位
合成対象の関数は reversi_accel です．また，上述の CFLAGS および Linker
Flags の設定も併せて行います．

高位合成だけを行う場合は，C Synthesis と Export HDL を行うだけです．
エクスポートの際，Vendor と Library には `AIT` と `DSLab` を指定します．
Version は，バージョン 2020.2 を使う場合は 1.0，2022.1 を使う場合は 1.1
に設定します．これ以外の設定でエクスポートした場合は，ブロック図作成の
ための tcl ファイルを修正する必要があります．

また，C Simulation を行う際は，Input Arguments にリバーシ盤の写った画像
のファイル名を記載します．サンプルとして `image080.jpg` を用意しています
ので，これを指定しても構いません．

C Simulation を行うと，
- output_cv.png にソフトウェア（OpenCV）での，
- output_hls.png にハードウェア（高位合成されるアルゴリズム）での，

実行結果がそれぞれ保存されます．

ハフ変換のみをハードウェア化したものを高位合成したい場合は，`hough_only`
フォルダのすべてのファイルを `C_src` フォルダにコピーしてください．

### デモシステムの論理合成

盤検出回路を組み込んだ回路のブロック図は，以下の手順で作成します．

1. Vivado で PYNQ-Z1/Z2 向けのプロジェクトを作成する
2. PROJECT MANAGER > Settings を開き，Project Settings > IP > Repository
   タブの IP Repositories リストの + から `ip_repo` フォルダを追加する
3. メニューの Tools > Run Tcl Script で `reversi_recognition_20XX_X.tcl`
   を実行する．うまく実行できれば，ブロック図が自動で作成され，Validate
   Design まで行われる．パラメータがおかしい旨の Critical warning が出る
   場合があるが，無視して構わない
4. PROJECT MANAGER > Add Sources から Add or create constraints を選択し，
   `pynq_hdmi.xdc` を追加する
5. 画面左上の Sources タブから Design Sources > design_1 を右クリックし，
   Create HDL Wrapper を実行する
6. Generate Block Design および Generate Bitstream を行う．dvi2rgb 関係で
   いくつかの Critical warning が出るが，無視して構わない
7. Vivado で生成できた .bit ファイルと .hwh ファイルを回収し，
   `reversi_hw.bit`, `reversi_hw.hwh` と名前を変更する．

### 実機での動作確認

動作確認のための Jupyter Notebook は2種類用意しています．いずれの場合でも，
回収した .bit ファイルと .hwh ファイル（または .xsa ファイル）を .ipynb
ファイルと同じフォルダに入れ，フォルダごと PYNQ にアップロードします．

その後，PYNQ 上の Jupyter Notebook で .ipynb ファイルを開き，Notebook 上
の説明に従って，各セルを実行してください．

------------------------------------------------------------------------

現在確認している問題
--------------------

論文中でも述べられていますが，ハフ変換のみをハードウェア化したものでは，
ボードの認識精度が低下します．論文では原因がライブラリのバグではないかと
推測していましたが，ハフ変換のコードに修正が加えられたバージョン 2024.2
でも，問題の解決は確認できませんでした．引き続き，原因を調査する必要が
あります．

------------------------------------------------------------------------

著作権
------

本リポジトリの `C_src` フォルダ中の C++ ソースコード，`Jupyter_demo` と
`Jupyter_eval` フォルダ中のノートブック，および `board_recognition.py`
**を除く** Python ソースコードは，
<a href="https://aitech.ac.jp/~dslab/nf/">藤枝 直輝</a>により開発され，
愛知工業大学 ディジタルシステム研究室が著作権を保有します．ライセンスは
New BSD です．コードの一部には，ディジタルシステム研究室の卒業生である
原田 大観，伊藤 直哉，彦坂 倖太郎の貢献を含みます．

なお，`ip_repo` フォルダ内の `axi_dynclk`，`dvi2rgb`，`rgb2dvi`，および
`tmds_v1_0` は，Digilent 社のハードウェアライブラリであり，MIT ライセンス
に従って再配布しています．これらのライブラリの入手先は以下の通りです．
> https://github.com/Digilent/vivado-library/

また，`ip_repo` フォルダ内の `overlay` は，別リポジトリで公開している，
HDMI 映像への画像重ね合わせコントローラです．本リポジトリのデモシステムの
ベースでもあります．このコントローラのリポジトリは以下の通りです．
> https://github.com/nfproc/HDMI_overlay/

`C_src` フォルダ中の `hough_software.hpp` は，Vitis vision library の一部
であり，C Simulation における比較のために抽出しています．リポジトリは以下
の通りです．
> https://github.com/xilinx/Vitis_Libraries/

`Jupyter_demo` と `Jupyter_eval` フォルダ中の `board_recognition.py` は，
lavox により開発されたリバーシの盤面認識プログラムであり，MIT ライセンス
に従って再配布しています．オリジナルの入手先は以下の通りです．
> https://github.com/lavox/reversi_recognition
著者による解説記事（日本語）を以下の URL で読むことができます．
> https://qiita.com/tanaka-a/items/fe6b95ae922b684021cc

ライセンスに関する詳細は LICENSE.txt を確認してください．

Copyright (C) 2022-2025 Digital Systems Laboratory. All rights reserved.
