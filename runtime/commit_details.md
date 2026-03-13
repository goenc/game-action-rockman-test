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
日時: 2026-03-14 02:18:34 JST
対象: debug/common/debug_inspect_utils.gd
summary: デバッグ選択でArea2Dを親へ昇格させずArea2D自体を選択対象に含めるよう修正した
変更:
・_resolve_pick_target の開始ノードを常に source_node とし Area2D の親強制切り替えを削除した
・_is_preferred_pick_target で Area2D を含む CollisionObject2D 全体を preferred target として扱うようにした
確認:
・tools/run.ps1 で起動開始を確認した
・godot と godot_console の起動を確認後に終了した
・弾クリックの手動確認は未実施
code_changes:
・debug_pick_owner と player_owner の既存ヒント処理や CollisionShape2D 非優先方針を維持したまま Area2D 自体を選択候補に残すようにした
verification:
・tools/run.ps1 実行後に Godot プロセス起動を確認した
・常駐起動のためコマンドはタイムアウトしたが起動成功を確認して終了した
