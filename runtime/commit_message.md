object_inspector の起動エラーとクリック選択不具合を修正

・object_inspector の起動時パースエラーを解消し DebugManager からの起動とクリック選択フローをローカル実装に合わせて正常化
・debug_inspect_utils.gd の parse error と型推論エラーを解消し 候補正規化と AnimatedSprite2D の強調範囲計算を安全化
・object_inspector_window.gd と object_pick_popup.gd の class_name 依存型注釈を外し 候補取得 0件1件複数件分岐 選択確定 選択解除を has_method ベースで安定化
・debug_select_overlay.gd でクリック座標を canvas transform からワールド座標へ変換し overlay 表示の z_index 上限超過も修正
・godot_console --path . --headless --verbose --quit-after 5 で起動時 parse error が出ないことを確認
・一時 headless 検証スクリプトで DebugManager から object inspector 起動 プレイヤー単体選択 複数候補ポップアップ再選択 選択対象削除時の解除を確認
・tools/run.ps1 の起動が 5 秒以上維持されることを確認