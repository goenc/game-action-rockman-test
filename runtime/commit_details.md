日時: 2026-03-11 16:56:41 JST
対象: 入力デバッガー
summary:
別ウインドウ表示の入力デバッガーを Autoload ベースで追加した
code_changes:
・debug 配下に DebugManager DebugWindow DebugInputPanel を追加し、全 InputMap アクション監視と生入力履歴表示を実装した
・project.godot に DebugManager の AutoLoad を追加し、起動時に入力デバッガー用 Window を生成するようにした
verification:
・tools/run.ps1 で Godot 4.6.1 を起動し、stderr が空のまま起動処理に入ることを確認した
