日時: 2026-03-11 21:11:46 JST
summary: 入力デバッガー上段の表示欠け対策と入力ログ表示ボタン導入を実装
target: debug/DebugWindow.tscn, debug/DebugWindow.gd, debug/DebugManager.gd, debug/panels/DebugInputPanel.tscn, debug/panels/DebugInputPanel.gd
code_changes:
・入力デバッガーウィンドウの初期サイズと最小サイズを拡大し上段表示用レイアウトをHBox化して右端に入力ログ表示ボタンを追加した
・上段ラベルと押下キー表示ラベルにautowrapとminimum sizeとsize flagsを設定して同時押し時の欠けを抑制した
・入力ログ表示ボタン押下シグナルを追加しDebugManagerの既存ログウィンドウ表示処理に接続した
verification:
・tools/run.ps1 起動でGodotプロセス起動を確認した
・入力デバッグ画面で単押しと複数同時押しを想定した表示欠け防止設定を反映した

