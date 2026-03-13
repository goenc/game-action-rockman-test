デバッグ管理ウィンドウのポーズ制御を実装

・Debug Manager Window に Pause CheckButton と状態同期用シグナルを追加
・DebugManager から GameManager を解決して SceneTree.paused の実状態へ同期する処理を追加
・GameManager の Pキー操作とデバッグ操作を共通の pause 実処理へ統一
・ヘッドレス読み込み確認と起動スクリプトの起動確認を実施
