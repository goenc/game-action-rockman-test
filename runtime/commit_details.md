日時: 2026-03-10 23:15:42 JST
対象: game-action-rockman-test
summary: 矩形描画だけで遊べるロックマン風1ステージの通しプレイ構成を実装
code_changes:
・タイトル画面とゲーム本編とクリア画面の状態遷移と Input Map 初期登録を実装
・プレイヤー移動とジャンプと単発ショットと被弾と無敵時間と HUD ライフ表示を実装
・JSON 定義のステージとタイル配置と歩行敵と砲台とボスと敵弾とカメラ追従を実装
verification:
・godot_console --path . --display-driver headless --quit-after 1 で起動確認
・tools/run.ps1 の起動を短時間確認

日時: 2026-03-11 02:04:21 JST
対象: game-action-rockman-test
summary: Stage の床正本を TileMapLayer へ移行して JSON 座標流し込みを廃止
code_changes:
・main.tscn の固定床ノード群を GroundLayer の TileMapLayer と ground_tileset.tres 参照に置き換えた
・stage_01.gd から tiles_root と _configure_tiles と setup と reset_stage の床再構成呼び出しを削除した
・stage_01.json の tiles を削除し tile_block.tscn に stage_tile グループを付けて既存の弾衝突判定を維持した
verification:
・godot_console --display-driver headless --path . --quit-after 1 で起動確認
・tools/run.ps1 の起動を 5 秒間確認
・headless 検証で GroundLayer 102 セルと床レイキャスト命中を確認
・TileMapLayer のセル追加保存と削除保存の roundtrip で 102→103→102 セルを確認