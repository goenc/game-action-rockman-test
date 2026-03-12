object_inspector の選択ウィンドウとクリック選択を修正

・pick popup を初期非表示にし、複数候補時のみ表示するように修正
・selection overlay の入力取得を _input ベースに変更してゲーム画面クリックを拾うように修正
・Viewport.find_world_2d() を使う候補収集に変更し、プレイヤー選択後の panel と overlay 更新を安定化
・headless 起動確認と smoke test で parse error なし、候補取得、選択反映を確認