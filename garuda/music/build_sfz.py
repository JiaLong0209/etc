#!/usr/bin/env python3
import os
import re

# 正則比對: {OrigKey}_{loVel}_{hiVel}_{Type}{Mic}{Index}.wav
pattern = re.compile(
    r"^([A-G][#b]?[0-9]+)_([0-9]+)_([0-9]+)_([A-Za-z]+?)(drr|hrr|rrr|xd|xh|xr)([0-9]+)\.wav$"
)

# 精確 13 組 1:1 白鍵映射字典
EXACT_MAPPING = {
    ("C1", "MK"): "c2",
    ("C1", "SNE"): "d2",
    ("F1", "SNE"): "e2",
    ("F1", "SNF"): "f2",
    ("G1", "SNF"): "g2",
    ("C3", "TA"): "a2",
    ("D3", "TA"): "b2",
    ("F2", "TA"): "c3",
    ("G2", "TA"): "d3",
    ("C1", "TMB"): "e3",
    ("D1", "TMB"): "f3",
    ("D1", "CYM"): "g3",
    ("F2", "CYM"): "a3",
}

samples_dir = "Samples"
sfz_output = "Epic_KIT_Manual.sfz"

regions = []

for filename in sorted(os.listdir(samples_dir)):
    if not filename.endswith(".wav"):
        continue

    match = pattern.match(filename)
    if not match:
        continue

    orig_key, lovel, hivel, inst_type, mic_type, idx = match.groups()

    # 僅選取 Direct / Close 系列 (drr 與 xd) 避免多 Mic 重疊爆音
    if mic_type not in ["drr", "xd"]:
        continue

    key_pair = (orig_key, inst_type)
    if key_pair not in EXACT_MAPPING:
        continue

    target_key = EXACT_MAPPING[key_pair]
    seq_length = 4 if "rr" in mic_type else 1

    regions.append({
        "sample": filename,
        "key": target_key,
        "lovel": int(lovel),
        "hivel": int(hivel),
        "seq_pos": int(idx),
        "seq_length": seq_length,
    })

with open(sfz_output, "w") as f:
    f.write("// Splash Sound - Percussion Elements 3 (13 Instruments Mapping)\n")
    f.write("<control>\n")
    f.write("default_path=Samples/\n\n")
    f.write("<global>\n")
    f.write("loop_mode=one_shot\n")
    f.write("ampeg_release=1.2\n\n")

    for r in regions:
        f.write(
            f"<region> sample={r['sample']} key={r['key']} "
            f"lovel={r['lovel']} hivel={r['hivel']} "
            f"seq_position={r['seq_pos']} seq_length={r['seq_length']}\n"
        )

print(
    f"[✓] 成功生成 {sfz_output}！13 種樂器已精確映射至 c2 ~ a3 白鍵（共 {len(regions)} 個 Region）。"
)
