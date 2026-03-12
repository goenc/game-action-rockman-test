デバッグ管理画面から個別デバッグウィンドウを開く構成へ整理

・DebugManager を管理画面と各デバッグウィンドウの生成、再表示、参照保持に限定
・Input Debugger と Input Log を別ウィンドウへ移設し既存 panel を流用
・入力状態と履歴を DebugInputData AutoLoad に分離し tools/run.ps1 で起動確認
