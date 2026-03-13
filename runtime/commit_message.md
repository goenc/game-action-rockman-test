Object Inspector のスクロール位置復元を追加

・Object Inspector の TextEdit 再代入を差分更新にしてスクロール位置が戻る不具合を修正
・Common と Extended の表示文字列をローカル変数に保持した
・TextEdit の既存文字列と差分がある場合のみ text を再代入するようにした
・再代入時に scroll_vertical を保存して代入後に復元するようにした
・tools/run.ps1 を5秒間起動し異常終了しないことを確認