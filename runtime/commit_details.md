日時: 2026-03-12 23:26:39 JST
対象: object_inspector
summary: object_inspector の popup 初期表示とクリック選択不全を修正
code_changes:
・pick popup を scene と _ready の両方で初期非表示にし、複数候補時のみ表示するように修正した
・selection overlay の入力取得を _input ベースへ切り替え、メインゲーム window のクリックを確実に拾うように修正した
・候補収集で Viewport.find_world_2d() を使うようにし、ゲーム描画先の world からプレイヤー候補を取得できるように修正した
verification:
・godot_console --headless --path . --quit-after 1 で parse error が出ないことを確認した
・tools/run.ps1 を 5 秒起動し、起動直後に終了せず継続起動できることを確認した
・headless の smoke test で popup 初期非表示、プレイヤー候補取得、選択後の panel 表示と overlay 更新を確認した
