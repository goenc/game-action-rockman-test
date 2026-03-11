player.gd の物理プロパティ更新を deferred 化

・player.gd の set_gameplay_active で collider と hurtbox の物理プロパティ更新を set_deferred に変更した
・物理シグナル中の状態変更エラー回避を目的とした最小変更に限定した
・tools/run.ps1 で起動確認を実施し開始成功を確認した
