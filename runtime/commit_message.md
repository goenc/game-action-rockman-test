デバッグ入力表示UIをControl自由配置へ変更し表示領域を拡大

・DebugInputPanel の Container ノードを除去し InputGroup 配下へラベルとボタンを直接配置した
・1行目右側へ 入力ログ表示 ボタンを追加配置し既存の入力ログ表示処理呼び出しを維持した
・DebugWindow の size と min_size を拡大し上部表示が欠けにくい初期設定へ調整した
・godot_console --headless --path . --quit の成功を確認した
