#!/bin/bash
BASE=/home/saverio/.openclaw/workspace/florishome-site
SRC=/home/saverio/.openclaw/media/inbound
STAGED=/home/saverio/.openclaw/workspace/media/inbound
mkdir -p "$BASE/foto-cliente"
declare -A MAP=( [1]=g1 [1_1]=g2 [1_2]=g3 [2]=g4 [2_1]=g5 [2_2]=g6 [3]=g7 [3_1]=g8 [3_2]=g9 [4]=g10 [4_1]=g11 [4_2]=g12 [bouquet]=g13 [bouquet_1]=g14 [bouquet_2]=g15 [FLOWER_BAR]=g16 )
for name in 1 1_1 1_2 2 2_1 2_2 3 3_1 3_2 4 4_1 4_2 bouquet bouquet_1 bouquet_2 FLOWER_BAR; do
  src=""
  for cand in "$SRC/$name---"*.png "$STAGED"/*/"input-$name---"*.png; do
    if [ -f "$cand" ]; then src="$cand"; break; fi
  done
  if [ -z "$src" ]; then echo "MISSING $name"; continue; fi
  cp "$src" "$BASE/foto-cliente/GALLERIA_$name.png"
  magick "$src" -auto-orient -resize '1600x1600>' -strip -quality 85 "$BASE/opt/${MAP[$name]}.jpg"
  echo "ok $name -> ${MAP[$name]}.jpg"
done
echo "== sizes =="
cd "$BASE/opt" && for i in $(seq 1 16); do magick identify -format "g$i %wx%h\n" "g$i.jpg" 2>/dev/null || echo "g$i MISSING"; done
