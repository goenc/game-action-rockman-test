Player弾を独立ノード化して追従しないよう修正

・Player配下の常駐弾を廃止し PackedScene 生成と current_bullet 管理で 1発制限を維持するよう変更
・Stage に PlayerBullets 配置先を追加し 発射済み弾を Stage 配下の独立オブジェクトとして扱うよう変更
・弾の消滅時に despawned と queue_free で参照と実体を解放し tools/run.ps1 の起動でエラーなしを確認