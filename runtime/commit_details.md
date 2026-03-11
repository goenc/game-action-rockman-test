日時: 2026-03-12 03:09:39 JST
summary: player.gd の物理プロパティ変更を deferred 化して物理シグナル中の状態変更エラーを回避した
target: scripts/player/player.gd
code_changes:
・set_gameplay_active の collider disabled と hurtbox monitoring monitorable と hurtbox_shape disabled を set_deferred に置換した
verification:
・tools/run.ps1 で起動確認を実施し開始成功を確認した

