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
日時: 2026-03-13 15:24:32 JST
対象: オブジェクト情報表示ウィンドウの概要欄追加
変更:
・object_inspector_panel.tscn に名前 座標 速度 状態 アニメ 判定の2列3行概要欄を追加し Common と Extended の配置を下方へ調整
・object_inspector_panel.gd に概要欄6項目の初期化と update_target での反映処理を追加
・debug_inspect_utils.gd に build_summary_inspect_data を新設し get_debug_inspect_data 優先の速度 状態 アニメ 判定取得と安全フォールバックを追加
確認:
・tools/run.ps1 を実行し Godot 起動待機状態に入ることを確認

