player を AnimatedSprite2D 表示へ切り替え

・player.tscn で idle run jump の SpriteFrames と idle autoplay を設定した
・player.gd で move_and_slide 後に idle run jump を切り替え、地上移動時のみ flip_h を更新するようにした
・jump 画像を player_jump.png として追加し、Godot の import と headless 起動を確認した
・既存の未追跡変更も指示どおり同時にコミットする