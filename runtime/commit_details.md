日時: 2026-03-13 15:32:07 JST
summary: デバッグ選択機能停止の原因だったdebug_inspect_utils.gdの型推論エラーを修正してユーティリティを再ロード可能にした
対象: debug/common/debug_inspect_utils.gd
code_changes:
・build_summary_inspect_data内のdebug_dataをVariant明示型に変更しコンパイルエラーを解消
verification:
・godot_console --path . --headless --quit が終了コード0で完了しパースエラー未発生を確認

