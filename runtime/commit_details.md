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
日時: 2026-03-11 23:11:35 JST
対象: debug/DebugWindow.tscn, debug/DebugLogWindow.tscn
変更:
・Window 直下の DebugInputPanel と DebugLogPanel の anchors_preset=15 と anchor_right=1.0 と anchor_bottom=1.0 を削除
・Window 直下の2ノードに anchor_left/top/right/bottom=0.0 を設定し Top Left 基本へ統一
・Window 直下で不要な grow_horizontal と grow_vertical を削除し size/position と .gd ロジックは未変更のまま維持
確認:
・tools/run.ps1 は常駐起動のため完走しないことを確認
・godot_console --path . --quit-after 120 --verbose --log-file runtime/run_check.log が終了コード0で成功
・起動ログで DebugWindow.tscn と DebugLogWindow.tscn と各パネル scene のロード成功を確認
