Object Inspector概要欄の速度とアニメ取得を修正

・概要欄の速度を get_debug_inspect_data の velocity/current_velocity 優先で取得し未提供時は対象ノードの velocity を直接参照して x,y 形式で表示するようにした
・概要欄のアニメを get_debug_inspect_data の animation/current_animation/anim 優先で取得し未提供時は AnimatedSprite2D 自身または子孫ノードから取得するようにした
・Object Inspector の update_target 内で概要欄データを明示的に受けて反映するようにした
・player.gd で velocity 更新箇所と sprite.play による animation 切替箇所を確認し get_debug_inspect_data が未実装であることを確認した
・godot_console --headless --path . --quit で起動確認を実施して成功した
