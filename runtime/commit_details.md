日時: 2026-03-11 20:12:55 JST
対象: debug/panels/DebugInputPanel.gd
変更:
・update_input_state から未定義の _event_log_label 参照を削除して主表示更新のみを担当する状態に修正
確認:
・tools/run.ps1 起動確認で launch_ok を確認

日時: 2026-03-11 20:26:00 JST
対象: scripts/game/enemy_bullet.gd
変更:
・deactivate 内の monitoring と monitorable の直接変更を set_deferred に置換
・deactivate 内の CollisionShape2D.disabled 直接変更を call_deferred("_disable_collision") に置換し補助関数を追加
確認:
・tools/run.ps1 は待機型起動のため 124 秒でタイムアウトしたがエラーログ出力なし
・godot_console --headless --path . --quit-after 1 が終了コード 0 で実行成功
・Cargo.toml 不在のため cargo 実行対象なし
