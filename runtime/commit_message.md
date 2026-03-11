DebugWindow と DebugLogWindow の初期レイアウト固定を scene 管理へ移行

・DebugWindow の _ready() から min_size と size の固定代入を削除し tscn 設定値を実行時に維持する構造へ変更
・DebugLogWindow の _ready() から min_size と size の固定代入を削除し tscn 設定値を実行時に維持する構造へ変更
・position は _move_near_main_window と _move_near_debug_window の実行時配置ロジックのため保持
・tools/run.ps1 の起動確認と対象 tscn の size/min_size 一致を確認
