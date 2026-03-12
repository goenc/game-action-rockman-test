日時: 2026-03-12 16:38:14 JST
対象: デバッグ管理画面経由の個別デバッグウィンドウ化
変更:
・DebugManager を管理画面と機能ウィンドウの生成、再表示、参照保持に限定し、管理画面ウィンドウを追加した
・Input Debugger と Input Log を debug/windows 配下へ移設し、既存 panel を流用して単独責務の別ウィンドウに整理した
・入力状態と入力履歴の保持を DebugInputData AutoLoad に分離し、起動時は Debug Manager のみ表示するよう project.godot を更新した
確認:
・tools/run.ps1 で起動し、8 秒間の起動維持とエラーログなしを確認した
