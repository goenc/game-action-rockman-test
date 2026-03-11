main をステージ動的ロード対応の本編ルートへ変更した

・main.tscn から Stage 実体を外して StageMount と stage_01 独立シーンへ分離した
・GameRoute autoload を追加し title_main から次ステージを設定して game_manager が動的生成する構成へ変更した
・headless 検証と tools/run.ps1 起動でタイトル開始 本編遷移 死亡リスタート クリア後タイトル戻りを確認した