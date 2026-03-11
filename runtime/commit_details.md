日時: 2026-03-12 01:15:58 JST
対象: タイトル専用シーン分離と既存デバッグUI調整
summary: タイトル画面を本編シーンから分離し起動専用シーン経由で本編へ遷移する構成へ変更した。
code_changes:
・project.godot の起動シーンを scenes/title_main.tscn に変更し scenes/title_main.tscn と scripts/ui/title_main.gd を追加した
・scenes/main.tscn から Title ノードを削除し scripts/game/game_manager.gd から TITLE 状態と  依存を除去して起動直後に本編開始しクリア後はタイトル専用シーンへ戻るよう変更した
・既存の debug/DebugWindow.tscn と関連シーンのレイアウト調整差分を同一コミットに含めた
verification:
・tools/run.ps1 を Godot 4.6.1 で --debug --quit-after 120 付きで実行し起動エラーなく終了することを確認した