Object Inspector の登録画像一覧を Summary 直下に追加

・Object Inspector のアニメーション表示を維持したまま Summary 直下に登録画像一覧を追加した
・Summary 直下に固定高さの登録画像一覧 ScrollContainer と一覧親コンテナを追加した
・登録画像一覧の更新処理を追加し サムネイル 区切り文字 長いファイル名の省略表示 0件時の なし 表示に対応した
・Extended 領域を追加情報の文字列表示へ戻し build_extra_inspect_data の内容を表示するようにした
・登録画像エントリ生成ヘルパーを追加し file_name と node_path を明示して返すよう整理した
・godot_console --headless --path . --script res://runtime/verify_object_inspector.gd で Player の登録画像 1 件と Summary 登録画像一覧の高さ 88.0 を確認した
・tools/run.ps1 を headless quit-after 1 で実行し 起動エラーなく立ち上がることを確認した
