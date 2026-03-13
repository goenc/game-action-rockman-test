日時: 2026-03-14 00:07:30 JST
対象: デバッグ管理ウィンドウのゲーム全体ポーズ切り替え
summary: Debug Manager Window から SceneTree.paused を使うゲーム全体のポーズ再開を操作できるようにした
code_changes:
・Debug Manager Window に Pause CheckButton と pause_toggled と set_pause_enabled を追加した
・DebugManager に GameManager 解決処理と pause 状態同期を追加し非ゲームシーンでは実状態へ表示を戻すようにした
・GameManager に set_paused_from_debug を追加し Pキー操作も同じ pause 実処理と HUD 同期を通すようにした
verification:
・godot_console --headless --path . --quit-after 1 でスクリプト読み込み成功を確認した
・tools/run.ps1 の起動で godot_console.exe が立ち上がることを確認した
