#!/bin/bash

# 引数があればそれを使用、なければ 2048 をデフォルトにする
BUFFER_SIZE=${1:-2048}

echo "🚀 Setting PipeWire buffer size (quantum) to: $BUFFER_SIZE"

# PipeWire のメタデータを更新してバッファサイズを強制固定
pw-metadata -n settings 0 clock.force-quantum "$BUFFER_SIZE"

# 反映を確認するために現在の状態を表示
echo "📊 Current PipeWire Status (Check QUANTUM column):"
pw-top -n 1 | grep --color=always "QUANTUM\|ID"
