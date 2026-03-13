日時: 2026-03-14 02:39:52 JST
対象: player bullet initial activation
summary: プレイヤー弾が発射直後から選択対象に残るよう初期化順を修正した
code_changes:
・PlayerBullet の _ready から deactivate(false) を削除し シーン初期値の無効状態をそのまま使うようにした
verification:
・tools/run.ps1 で起動確認を実施し 起動直後の異常終了がないことを確認した
