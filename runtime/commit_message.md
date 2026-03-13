オブジェクトインスペクタに概要欄を追加

・名前 座標 速度 状態 アニメ 判定を常時表示する2列3行の概要欄を追加
・概要欄の表示更新を show_empty と update_target に実装
・概要欄専用の inspect データ生成関数を追加し既存 Common と Extended 表示仕様を維持
・tools/run.ps1 で起動確認を実施