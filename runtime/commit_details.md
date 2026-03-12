日時: 2026-03-12 22:26:09 JST
summary: デバッグ管理画面から起動できるオブジェクトインスペクターを追加した
対象: debug
code_changes:
・DebugManager と debug manager window に object inspector の別ウィンドウ導線を追加した
・クリック位置の物理問い合わせと候補選択ポップアップを object_inspector 配下へ追加した
・詳細表示パネルと選択強調オーバーレイと自動解除更新を実装した
verification:
・tools/run.ps1 で Godot を起動し Debug Manager ウィンドウが立ち上がることを確認した