#!/bin/bash

# ==========================================
# 配置區域 (Config)
# ==========================================
DEVICE_NAME="20:0"
MOUSE_SPEED=30
T4_CONTROLLER=91

# 轉調位移 (C3=48, C2=36, 所以從 C3 轉到 C2 是 -12)
TRANSPOSE_OFFSET=0
# TRANSPOSE_OFFSET=-12

# 基礎映射表 (以 C3 為基準)
declare -A BASE_KEY_MAP=(
    ["48"]="shift" # C
    ["50"]="a"     # D
    ["52"]="s"     # E
    ["53"]="d"     # F
    ["55"]="f"     # G
    ["57"]="space" # A
)

# ==========================================
# 邏輯處理 (Logic)
# ==========================================

# 1. 鍵盤事件處理器
handle_note_event() {
    local type=$1
    local raw_note=$2
    
    # 計算校正後的音符 (Dependency Inversion: 邏輯依賴於計算後的數值)
    local adjusted_note=$((raw_note - TRANSPOSE_OFFSET))
    local key=${BASE_KEY_MAP[$adjusted_note]}

    [[ -z "$key" ]] && return

    if [[ "$type" == "on" ]]; then
        xdotool keydown "$key"
    else
        xdotool keyup "$key"
    fi
}

# 2. 滑鼠移動處理器
last_val=64
handle_mouse_move() {
    local current_val=$1
    if [[ "$current_val" -gt "$last_val" ]]; then
        xdotool mousemove_relative -- $MOUSE_SPEED 0
    elif [[ "$current_val" -lt "$last_val" ]]; then
        xdotool mousemove_relative -- -$MOUSE_SPEED 0
    fi
    last_val=$current_val
}

# 3. 核心串流解析
process_midi_stream() {
    echo "監聽中: $DEVICE_NAME | 偏移量: $TRANSPOSE_OFFSET | 起始鍵: C2"
    
    aseqdump -p "$DEVICE_NAME" | while IFS=" ," read -r src ev1 ev2 ch label1 data1 label2 data2 rest; do
        case "$ev1 $ev2" in
            "Note on")
                [[ "$data2" -gt 0 ]] && handle_note_event "on" "$data1" || handle_note_event "off" "$data1"
                ;;
            "Note off")
                handle_note_event "off" "$data1"
                ;;
            "Control change")
                [[ "$data1" == "$T4_CONTROLLER" ]] && handle_mouse_move "$data2"
                ;;
        esac
    done
}

process_midi_stream

