debug 機能の責務整理と inspector 更新経路の限定リファクタリング

・DebugManager の manager window 接続と hitbox overlay 状態同期を内部関数に整理
・DebugManagerWindow のボタン接続を UI ロジックとして集約
・ObjectInspectorWindow が選択更新データを構築し ObjectInspectorPanel が表示反映を担う形に整理
・未使用UI候補 ExtraTitleLabel と ExtraInfoText が現行ソースに存在しないことを確認
・godot_console と tools/run.ps1 で起動継続とエラーなしを確認
