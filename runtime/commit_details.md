日時（JST）: 2026-03-13 20:33:58 JST
対象: Player弾の独立ノード化と弾配置先の分離
summary: Player配下の常駐弾を廃止し 発射済みの弾がPlayerに追従しないよう独立ノード化した
変更:
・player.tscn から Bullet 子ノードを削除し player.gd を PackedScene 生成と current_bullet 管理へ変更した
・stage_01 に PlayerBullets ノードと配置先取得メソッドを追加し プレイヤー弾を Stage 配下へ配置するようにした
・player_bullet.gd で消滅時に despawned を使って参照解放できるようにし 発射済み弾を個別に解放する運用へ変更した
code_changes:
・Player は setup と reset_for_stage で弾設定を保持し set_gameplay_active(false) とステージリセット時に current_bullet を deactivate(false) して参照を null に戻すようにした
・弾の発射位置は global_position + Vector2(facing * 18.0, -4.0) を維持し 1発制限は current_bullet の有効性で判定するようにした
・デバッグ選択は親子構造の解消で弾を独立対象として扱える前提になったため debug 系スクリプトは未変更とした
確認:
・tools/run.ps1 の起動で Godot Engine v4.6.1 の立ち上がりを確認し 標準エラーが空であることを確認した
verification:
・PlayerBullets 配置先の追加と player_bullet の独立解放により 発射済み弾が Player の子として追従しない構造へ変わっていることをソース上で確認した
