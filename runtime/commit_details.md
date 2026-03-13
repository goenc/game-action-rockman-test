日時: 2026-03-14 00:44:02 JST
対象: scripts/game/game_manager.gd, debug/DebugManager.gd
summary: ポーズ入力の受付をDebugManagerへ移し停止制御をSceneTree.pausedへ統一した
変更:
・GameManagerの常時処理指定を外し pause 入力処理を削除して clear 画面の ui_accept のみを残した
・GameManagerに is_pause_toggle_allowed を追加し set_paused_from_debug を停止制御と HUD 同期の共通窓口として維持した
・DebugManagerに常時 _process と pause 入力監視を追加し GameManager が PLAYING のときだけ set_game_paused で停止を切り替えるようにした
確認:
・tools/run.ps1 で起動開始を確認した
・headless 起動が成功した
・P キーや START ボタンの実機手動確認は未実施
code_changes:
・pause の責務を GameManager から DebugManager に移し player stage collision 個別制御を追加せず SceneTree.paused のみを使う構成にした
verification:
・tools/run.ps1 による起動確認を実施した
・godot_console の headless 起動成功を確認した
