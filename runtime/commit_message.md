当たり判定表示オーバーレイを追加

・既存の DebugManager 構成を維持したまま当たり判定表示オーバーレイを追加
・debug 配下に hitbox オーバーレイと TileMapLayer 外周線ビルダーを追加し プレイヤー 敵 地面を色分け表示できるようにした
・DebugManager と DebugManagerWindow に入力デバッガー系と独立したヒットボックス表示トグルの入口だけを追加した
・player enemy boss stage scene に debug 用 group を追加し ゲームロジックを変えずに表示対象を収集できるようにした
・tools/run.ps1 を起動し 5 秒間の起動確認で Parse Error や起動エラーが出ないことを確認した