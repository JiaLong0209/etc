# 個人音樂創作語意化版本規範

本規範專為個人高頻修改、自娛創作、不對外交付的 DTM / REAPER 專案制定。

核心原則：嚴格採用 vX.Y.Z 三段式結構，並將 Master Track 上的 Spectrum Matcher 插件序號作為 A/B Test 標籤追加在後綴。

---

## 1. 完整格式定義

格式：[曲目/專案名]_[日期(YYMMDD)]_v[X].[Y].[Z][-eqN].[ext]

- 基本結構範例：no.23_260920_v0.0.2-eq6.mp3
- 不帶 EQ 測試時：no.23_260920_v0.0.2.mp3

---

## 2. 三段版本號 (vX.Y.Z) 定義邏輯

因為是個人創作、可能永遠都在改動，不需要死板照搬商業軟體交付標準，推薦以下實用對應：

| 欄位 | 名稱 | 觸發條件（何時數字 +1） | 歸零規則 |
| :--- | :--- | :--- | :--- |
| X (MAJOR) | 曲式/結構重構 | 增刪大段落、重寫和弦架構（時長改變） | X + 1 時，Y 與 Z 歸零（例如 v0.12.8 -> v1.0.0） |
| Y (MINOR) | 旋律/對位/和聲改寫 | 重寫主旋律線、對位聲部、和聲進行 (時長不變) | Y + 1 時，Z 歸零（例如 v0.0.9 -> v0.1.0） |
| Z (PATCH) | 細節修飾/微調 | 調 MIDI 力度、更換樂器、修改音符錯音 (聽感不變) | 只要存檔或匯出試聽就 Z + 1（改 40 幾次完全沒問題：v0.0.42） |

---

## 3. 後綴標籤：-eq[N]

後綴 -eq[N] 代表 REAPER Master Track 上的 JS: Spectrum Matcher 實例索引：

- no.23_260920_v0.1.4-eq6.mp3
- no.23_260920_v0.1.4-eq4.mp3

代表意義：
- 兩者在 v0.1.4 下的音樂內容（MIDI、軌道音量、配器）完全相同。
- 差異僅在於掛載了第 6 個（如 Bright EQ）或第 4 個（如 Dark EQ）Spectrum Matcher 進行母帶聽感盲測。

---

## 4. 變更紀錄備忘（REAPER Project Notes）

在 REAPER 內按 File -> Project settings -> Project Notes，隨手記下：

=== Master Matcher Index ===
eq4: Dark / Warm Match
eq6: Bright / Aggressive Match (主推)

=== Changelog ===
v0.1.0: 完成弦樂與鼓組主體配器
v0.1.4: 修正副歌銅管力度，補上一段 Crash
v0.1.4-eq6: 測試高頻染色
