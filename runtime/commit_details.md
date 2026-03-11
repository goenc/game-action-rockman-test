日時: 2026-03-11 21:36:01 JST
対象: debug/DebugWindow.tscn, debug/DebugWindow.gd, debug/panels/DebugInputPanel.tscn, debug/panels/DebugInputPanel.gd
変更:
・DebugInputPanel の MarginContainer/VBoxContainer/HBoxContainer を除去し、Control 配下でラベルとボタンを自由配置に変更
・1行目左側に CurrentInputLabel、右側に 入力ログ表示 ボタンを固定配置し、既存 signal 経由のログ表示処理接続を維持
・DebugWindow の size と min_size を拡大して同時押し時の上部表示欠けを抑制
確認:
・godot_console --headless --path . --quit が終了コード 0 で成功

日時: 2026-03-11 22:51:59 JST
対象: debug/DebugWindow.gd, debug/DebugLogWindow.gd
変更:
・DebugWindow の _ready() から min_size と size の固定代入を削除し scene 側の初期値を正本化
・DebugLogWindow の _ready() から min_size と size の固定代入を削除し scene 側の初期値を正本化
確認:
・tools/run.ps1 を起動し Godot プロセスが立ち上がることを確認した
・DebugWindow.tscn と DebugLogWindow.tscn に従来と同じ size/min_size が設定済みで position ロジック未変更を確認した
