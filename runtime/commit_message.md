Object Inspector の Extended に登録画像一覧を表示

・Object Inspector の Extended 領域で登録画像をファイル名とサムネイル付き一覧表示できるようにした
・Extended を ScrollContainer ベースの一覧 UI に差し替え、画像 0 件時は専用ラベルだけを表示するようにした
・選択ノードと子孫ノードから Sprite2D.texture と AnimatedSprite2D の現在フレーム texture を収集し、同一ノード内の重複を除外する関数を追加した
・show_empty と update_target を一覧クリアと一覧更新処理へ置き換えた
・headless 実行で Player を対象に player_idle.png の行とサムネイル texture が生成されることを確認した
・tools/run.ps1 でプロジェクトが起動開始することを確認した