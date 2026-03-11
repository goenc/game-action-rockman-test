datetime: 2026-03-12 02:41:19 JST
target: EnemyWalker 初期化順
summary: EnemyWalker の初期無効化が configure 後に再適用される問題を修正した。
code_changes:
・EnemyWalker の deactivate から二重遅延を外し configure 後の有効化状態が維持されるようにした。
verification:
・headless で main.tscn を読み込み Walker01 から Walker03 が alive=true かつ visible=true になることを確認した。
・headless で Walker04 が alive=false かつ visible=false のまま残ることを確認した。
・tools/run.ps1 の起動確認が成功した。

