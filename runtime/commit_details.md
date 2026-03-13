日時: 2026-03-13 22:45 JST
対象: debug 機能の限定リファクタリング
summary: DebugManager と Object Inspector の責務を整理し未使用UI候補の未存在確認を行った
code_changes:
・DebugManager で manager window の signal 接続と hitbox overlay 状態同期を内部関数へ集約した
・DebugManagerWindow のボタン接続を _connect_feature_buttons() に整理した
・ObjectInspectorWindow が選択対象管理と inspector 表示データ構築を担い Panel 連携を明確化した
・ObjectInspectorPanel に表示データ反映用メソッドと common 情報スクロール維持処理を集約した
verification:
・rg -n "ExtraTitleLabel|ExtraInfoText" . で候補 UI 名が現行ソースに存在しないことを確認した
・godot_console --path . --quit-after 60 で起動し parse error と missing node エラーがないことを確認した
・tools/run.ps1 を再実行し起動が継続することを確認した
