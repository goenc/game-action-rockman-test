player 表示を AnimatedSprite2D に置き換え

・player の表示を AnimatedSprite2D ベースへ揃え、停止時と移動時のアニメーション切替が成立する状態にした
・player.tscn から仮表示用の Polygon2D Body を削除し、既存の AnimatedSprite2D と SpriteFrames を表示ノードとして残した
・player.gd の onready 参照を AnimatedSprite2D に統一し、速度に応じて idle と run を切り替えつつ同一 animation の再生を抑止した
・player.gd の _apply_size から Polygon2D 更新を削除し、当たり判定サイズの更新だけを維持した
・assets/player/player_idle.png と assets/player/player_run_1.png から assets/player/player_run_3.png の実在を確認した
・tools/run.ps1 で Godot Engine 4.6.1 の起動を確認し、初期化エラーが出ていないことを確認した