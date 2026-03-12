プレイヤー画像と移動アニメーションを追加

・追加したプレイヤー画像アセットをプロジェクトに反映した。
・assets/player に player_idle.png と player_run_1.png から player_run_3.png を追加した。
・godot_console を --path . で起動し5秒間の起動確認後に終了して起動可能であることを確認した。
・player の横移動状態に応じて idle と run のアニメーションを切り替える処理を実装した。
・player.tscn に AnimatedSprite2D と SpriteFrames を追加し idle と run のアニメーションを設定した。
・player.gd の _physics_process で velocity.x に応じた idle と run の切替と左右反転を追加し同一アニメーションの再生連打を防止した。
・tools/run.ps1 で Godot Engine v4.6.1.stable.official.14d19694e が起動し D3D12 初期化まで進むことを確認した。