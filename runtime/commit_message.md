ポーズ入力をDebugManagerへ移管して停止制御を統一

・ポーズ入力の受付をDebugManagerへ移し停止制御をSceneTree.pausedへ統一した
・pause の責務を GameManager から DebugManager に移し player stage collision 個別制御を追加せず SceneTree.paused のみを使う構成にした
・tools/run.ps1 による起動確認を実施した
・godot_console の headless 起動成功を確認した
