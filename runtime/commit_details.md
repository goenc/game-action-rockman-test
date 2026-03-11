日時: 2026-03-12 02:59:22 JST
対象: boss被弾時の物理状態切替
変更:
・Boss の _enable_nodes() で CollisionShape2D.disabled と Area2D.monitoring と Area2D.monitorable の直接変更を set_deferred() に置き換えた
確認:
・player_bullet.gd の _on_area_entered() から Boss.take_damage() を経由して _enable_nodes(false) に入る経路をソースで確認した
・tools/run.ps1 で Godot 4.6.1 が起動し scenes/main.tscn と scripts/game/boss.gd の読み込み成功を確認した
