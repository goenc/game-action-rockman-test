日時: 2026-03-13 20:10:26 JST
summary: Object Inspector概要欄で速度とアニメが取得表示されるように修正
対象: debug/common/debug_inspect_utils.gd, debug/panels/object_inspector/object_inspector_panel.gd
code_changes:
・概要欄の速度取得を debug データ優先かつ velocity 直接参照フォールバックに変更し x,y 形式で整形
・概要欄のアニメ取得を debug データ優先かつ AnimatedSprite2D 自身と子孫探索フォールバックに変更
・Object Inspector の update_target で概要欄データをローカル変数に受けて反映する形に整理
verification:
・player.gd で velocity 更新と sprite.play による animation 切替を確認
・player.gd に get_debug_inspect_data が未実装であることを確認
・godot_console --headless --path . --quit が成功しスクリプトエラーがないことを確認
