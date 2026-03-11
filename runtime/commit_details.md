日時: 2026-03-12 01:45:34 JST
summary: main をステージ動的ロード対応の本編ルートへ変更した
target: project.godot / scenes/main.tscn / scenes/stages/stage_01.tscn / scripts/game/game_manager.gd / scripts/game/game_route.gd / scripts/ui/title_main.gd
code_changes:
・main.tscn から Stage 実体を外して StageMount を追加し scenes/stages/stage_01.tscn へ切り出した
・GameRoute autoload を追加し title_main で次ステージを設定して game_manager が StageMount に動的生成する構成へ変更した
・死亡時リスタートとクリア後タイトル戻りを生成済み stage 参照のまま維持した
verification:
・godot_console --headless --verbose --path . --script .\\runtime\\route_validation.gd --quit-after 120 --log-file .\\runtime\\route_validation.log でタイトル開始 本編遷移 死亡リスタート クリア後タイトル戻りを確認した
・tools/run.ps1 の起動成功を確認した
