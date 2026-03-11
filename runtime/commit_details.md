日時: 2026-03-11 20:45:29 JST
対象: scripts/game/enemy_walker.gd
変更:
・enemy_walker.gd の deactivate からノード有効無効反映を call_deferred で遅延実行するよう変更
・enemy_walker.gd の _enable_nodes で Area2D.monitoring と monitorable を set_deferred 化
・enemy_walker.gd の CollisionShape2D.disabled 切替を _set_collision_enabled に分離し call_deferred で実行
確認:
・tools/run.ps1 を起動監視し Godot プロセス起動を確認
・物理シグナル中の即時状態変更を回避する実装に置換したことをコード確認

