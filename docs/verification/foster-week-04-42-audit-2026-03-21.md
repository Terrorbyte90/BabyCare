# Fetal Illustration Verification Audit

Scope: `Sources/BabyCare/PregnancyWeekData.swift` and `App/Assets.xcassets/foster_week_04...42`

## Executive Summary

Overall progression is directionally correct, but the series has two important gaps:

1. Weeks 8-10 stay too embryo-like for too long, so the embryo -> early fetus transition is delayed.
2. The generator is capped at week 40, while the asset set and week data run to week 42.

The mid-pregnancy bands are generally plausible, but the late bands need stronger visual differentiation to read as late-term rather than simply "slightly larger" versions of the mid-term fetus.

## Verification Matrix

| Band | Status | What must be visible | What must be absent | Current read | Recommended change |
|---|---|---|---|---|---|
| 4-7 | PASS | Tiny embryo form, sac/placenta context, minimal body definition | Distinct limbs, face detail, newborn-like proportions | Matches the intended embryonic stage | Keep embryo treatment; do not add limbs before week 8 |
| 8-12 | FAIL | Clear transition to early fetus by week 8-10, with a visible head mass, limb buds, and a stronger C-curve | Dot-like embryo silhouette, fully formed face, mature fingers/toes | Week 8-10 still reads embryo-like; week 11 is the first clearly fetal frame | Move early-fetus visual onset to week 8; increase head/body mass and limb visibility gradually across 8-12 |
| 13-20 | PASS | Clear fetal silhouette, larger head vs body, visible arms and legs, still curved | Newborn roundness, fully filled torso | Plausible second-trimester fetal look | Keep current stage, but add slightly more week-to-week growth if you want stronger progression |
| 21-28 | PASS | Longer fetus, recognizable hands/feet, more mature proportions, still inside sac | Newborn-like fullness, straightened infant pose | Reads as a later fetal stage and fits the band | Minor polish only; current art is acceptable |
| 29-36 | FAIL | Fuller torso, thicker limbs, more sac occupancy, clear late-stage growth | Slim mid-fetus proportions, nearly unchanged pose from 21-28 | Visual change is too subtle; the band still looks too close to mid-fetus | Split late-stage into a fuller 29-36 profile with increased body width and slightly reduced curl |
| 37-42 | FAIL | Near-term fullness, stronger late-term presence, visible separation from week 40, still prenatal | Week-40 clone behavior, static proportions, newborn post-birth cues | Week 41-42 are present in assets, but the generator cannot regenerate them distinctly and the visuals remain only marginally different | Add a term stage, raise the week ceiling to 42, and push final-week body mass/proportions further |

## Concrete Generator Corrections

### 1) Fix the week ceiling

Current code:
- `Sources/BabyCare/FetalIllustrationGenerator.swift:8-10`

Recommended:
- Set `maximumWeek = 42`
- Keep `fallbackWeek = 20`

Why:
- The asset set and `PregnancyWeekData` both include weeks 41-42.
- With the current ceiling, any regeneration clamps those weeks to week 40 behavior.

### 2) Split the visual stages more cleanly

Current stage mapping:
- `1...7 = embryo`
- `8...15 = earlyFetus`
- `16...27 = midFetus`
- `28...42 = lateFetus` via `default`

Recommended stage mapping:
- `1...7 = embryo`
- `8...12 = earlyFetus`
- `13...28 = midFetus`
- `29...36 = lateFetus`
- `37...42 = termFetus`

Why:
- The current single late stage is too broad for the final 14 weeks.
- A dedicated term stage gives weeks 37-42 enough room to feel meaningfully closer to delivery.

### 3) Tune size/proportion parameters by band

Current shared parameters in `drawFetus`:
- `headRadius = lerp(30, 62, t) * scaleFactor`
- `bodyWidth = lerp(18, 38, t) * scaleFactor`
- `bodyLength = lerp(84, 320, t) * scaleFactor`
- `limbAlpha = 0.0 / 0.65 / 0.95`
- face detail appears for every non-embryo stage

Recommended tuning:

- Weeks 4-7
  - Keep `limbAlpha = 0`
  - Keep tail-like embryonic curve only
  - Avoid any visible face detail

- Weeks 8-12
  - Increase `headRadius` about 10-15% relative to the current embryo look
  - Increase `bodyLength` about 15-20%
  - Set `limbAlpha` to start lower, around `0.30-0.45`, then ramp to `0.65`
  - Delay eye/face detail until week 11 or 12

- Weeks 13-20
  - Keep `limbAlpha` near `0.75-0.90`
  - Slightly widen `bodyWidth` so the fetus stops reading as "slender embryo"
  - Maintain a strong fetal curl

- Weeks 21-28
  - Keep limbs fully visible
  - Increase `bodyLength` enough to look clearly more mature than 13-20
  - Keep the pose curled, but reduce the "tiny" feel

- Weeks 29-36
  - Raise `bodyWidth` by roughly 15-25% over the current late-mid look
  - Increase `bodyLength` by roughly 8-12%
  - Make the body occupy more of the sac
  - Reduce the pose curl slightly so the fetus looks fuller, not just larger

- Weeks 37-42
  - Use a dedicated `termFetus` stage with the strongest proportions
  - Increase `headRadius` and `bodyWidth` again so the fetus feels near-term
  - Keep the fetus prenatal, but visibly closer to delivery than week 30
  - Ensure week 41 and 42 are not just tiny variants of week 40

## Notes on App Usage

- `Sources/BabyCare/WeekByWeekView.swift:223-231` correctly loads the asset by week name, so the UI side is structurally fine.
- `Sources/BabyCare/PregnancyWeekData.swift` already has week-by-week content through 42, so the content model is not the bottleneck.

## Bottom Line

- Pass: 4-7, 13-20, 21-28
- Fail: 8-12, 29-36, 37-42
- Highest priority fix: extend the generator to week 42 and split the late-stage visuals so the last trimester does not plateau visually.
