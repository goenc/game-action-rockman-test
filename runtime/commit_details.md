日時: 2026-03-12 20:59:14 +09:00
対象: player の表示を AnimatedSprite2D 化し idle run jump を切り替える対応
変更:
・player.tscn の AnimatedSprite2D に idle run jump の SpriteFrames と idle autoplay を設定した
・player.gd の _physics_process で move_and_slide 後に地上判定を見て idle run jump を切り替え、地上移動時のみ flip_h を更新するようにした
・jump 画像を player_jump.png として追加し、Godot で import 可能な状態にした
確認:
・tools/run.ps1 は起動後 15 秒間継続し、即時エラーなく立ち上がることを確認した
・godot_console --headless --path . --import --quit が終了コード 0 で完了した
・godot_console --headless --path . --quit-after 5 が終了コード 0 で完了した
