日時: 2026-03-13 21:51:44 JST
summary: Object Inspector の登録画像を現在フレームではなく全登録画像一覧で確認できるようにした
code_changes:
・AnimatedSprite2D の SpriteFrames から全アニメーション名と全フレームを走査し texture file_name node_path animation_name frame_index を持つ登録画像一覧を収集するよう変更
・Object Inspector に登録画像セクションを追加し サムネイルとファイル名と animation frame 情報をスクロール一覧で表示するよう変更
verification:
・tools/run.ps1 を別プロセス起動し Godot と godot_console の起動を確認した