日時: 2026-03-13 22:04:17 JST
summary: Object Inspector の Extended セクションを削除し Common 表示を拡張して日本語化
対象: debug/panels/object_inspector/object_inspector_panel.gd, debug/panels/object_inspector/object_inspector_panel.tscn, debug/common/debug_inspect_utils.gd
code_changes:
・Object Inspector の script から Extended の onready 参照と空表示時の初期化と更新時の生成およびスクロール復元処理を削除した
・Object Inspector の scene から Extended 見出しとテキスト欄を削除し Common 見出しを共通情報へ変更して表示領域を下方向へ拡張した
・Common の表示キーを日本語へ変更し値の中身と TextEdit の折り返しおよびスクロール挙動は維持した
verification:
・tools/run.ps1 を使用して起動を 8 秒間確認し エラーなく起動継続することを確認した
