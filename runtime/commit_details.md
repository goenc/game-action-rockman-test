日時: 2026-03-11 20:12:55 JST
対象: debug/panels/DebugInputPanel.gd
変更:
・update_input_state から未定義の _event_log_label 参照を削除して主表示更新のみを担当する状態に修正
確認:
・tools/run.ps1 起動確認で launch_ok を確認
