デバッグウィンドウ直下パネルの Anchor を Top Left 基本へ統一

・DebugInputPanel の UI 構成を Control 自由配置へ変更し既存 signal 接続を維持した履歴を反映
・DebugWindow と DebugLogWindow の size/min_size は scene 正本を維持し .gd の固定代入を削除した履歴を反映
・Window 直下の DebugInputPanel と DebugLogPanel で Full Rect 由来の Anchor と grow 設定を削除し anchor_* を 0.0 へ統一
・headless 起動確認と quit-after 起動確認が終了コード0で成功し対象 scene のロードを確認
