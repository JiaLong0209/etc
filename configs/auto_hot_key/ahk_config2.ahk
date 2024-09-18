#Persistent  ; Keep the script running

Capslock::Esc

; Remap Right Alt to Caps Lock
RAlt::return

; Define key mappings
RAlt & h::Left
RAlt & s::Left
RAlt & j::Down
RAlt & k::Up
RAlt & l::Right
RAlt & d::Right

RAlt & x::Delete
RAlt & z::Backspace
RAlt & q::Backspace

RAlt & o::Enter
RAlt & p::Enter

RAlt & u::^z  ; Ctrl + Z
RAlt & r::^+z ; Ctrl + Shift + Z
RAlt & i::^+z ; Ctrl + Shift + Z
RAlt & a::^Left ; Ctrl + Left
RAlt & b::^Left ; Ctrl + Left
RAlt & e::^Right ; Ctrl + Right
RAlt & f::^Right ; Ctrl + Right
RAlt & w::^Backspace ; Ctrl + Backspace

; Activates when both Right Alt and Shift are pressed
RAlt & Shift::  ; Right Alt + Shift
    RAlt & h::+Left
    RAlt & j::+Down
    RAlt & k::+Up
    RAlt & l::+Right
    RAlt & s::+Left
    RAlt & d::+Right
    RAlt & x::^Delete  ; Ctrl + Delete
    RAlt & w::^+Backspace ; Ctrl + Shift + Backspace
    RAlt & z::^Backspace ; Ctrl + Backspace
    RAlt & q::^Backspace ; Ctrl + Backspace
    RAlt & o::^+Enter ; Ctrl + Shift + Enter
return

