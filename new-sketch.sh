#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
# new-sketch
# a script to scaffold a new p5.js sketch in the playground repo.
#
# this file lives in the playground repo as a reference and is executed
# via an alias in ~/.zshrc. if you need to set it up again on a new machine:
#
#   1. add this line to ~/.zshrc:
#      alias new-sketch='/Users/melissarodriguez/Documents/creative_coding/playground/new-sketch.sh'
#   2. run: source ~/.zshrc
#   3. you can now run `new-sketch` from anywhere
#
# note: `cd` into the sketch folder won't work from a .sh file (it runs in
# a subshell). vs code will open the sketch folder automatically instead.
# ─────────────────────────────────────────────────────────────────────────────

PLAYGROUND_DIR="/Users/melissarodriguez/Documents/creative_coding/playground"
EMPTY_EXAMPLE="$PLAYGROUND_DIR/empty-example"
README="$PLAYGROUND_DIR/README.md"

# ── dates ─────────────────────────────────────────────────────────────────────
YEAR=$(date +%Y)
YEAR_SHORT=$(date +%y)
DATE_FULL=$(date +%Y-%m-%d)

# ── figure out next sketch number ─────────────────────────────────────────────
YEAR_DIR="$PLAYGROUND_DIR/$YEAR"

if [ ! -d "$YEAR_DIR" ]; then
  mkdir -p "$YEAR_DIR"
  echo "📁 created $YEAR/ folder"
fi

EXISTING=$(ls -d "$YEAR_DIR"/${YEAR_SHORT}[0-9][0-9][0-9] 2>/dev/null | wc -l | tr -d ' ')
NEXT=$(printf "%03d" $((EXISTING + 1)))
SKETCH_ID="${YEAR_SHORT}${NEXT}"
SKETCH_NAME="${YEAR}${NEXT}"
SKETCH_DIR="$YEAR_DIR/$SKETCH_ID"

echo "✏️  creating sketch $SKETCH_NAME..."

# ── copy empty-example ────────────────────────────────────────────────────────
cp -r "$EMPTY_EXAMPLE" "$SKETCH_DIR"

# ── write sketch.js ───────────────────────────────────────────────────────────
printf '// %s\n// melissa-rodriguez\n// %s\n\nfunction setup(){\n  createCanvas(1000, 1000);\n}\n\nfunction draw(){\n  background(240);\n  ellipse(width/2, height/2, 200);\n}\n' "$SKETCH_NAME" "$DATE_FULL" > "$SKETCH_DIR/sketch.js"

# ── write project README ──────────────────────────────────────────────────────
printf '# %s\n\n# preview\n![01](outputs/01.png)\n' "$SKETCH_NAME" > "$SKETCH_DIR/README.md"

# ── update playground README ──────────────────────────────────────────────────
THUMB_PATH="${YEAR}/${SKETCH_ID}//outputs/01.png"
THUMB_LINK="${YEAR}/${SKETCH_ID}//"
IMG_TAG="<a href='${THUMB_LINK}'><img src='${THUMB_PATH}' height='200' style='margin: 5px;'></a>"

if grep -q "^## $YEAR$" "$README"; then
  awk -v header="## $YEAR" -v img="$IMG_TAG" '
    $0 == header { print; print img; next }
    { print }
  ' "$README" > "$README.tmp" && mv "$README.tmp" "$README"
else
  awk -v year="$YEAR" -v img="$IMG_TAG" '
    /^## 20[0-9][0-9]$/ && !done {
      print "## " year
      print img
      print ""
      done=1
    }
    { print }
  ' "$README" > "$README.tmp" && mv "$README.tmp" "$README"
fi

# ── commit to playground repo ─────────────────────────────────────────────────
cd "$PLAYGROUND_DIR"
git add .
git commit -m "new sketch $SKETCH_NAME"
echo "✅ committed to playground repo"

# ── push to remote ────────────────────────────────────────────────────────────
  git push
  echo "🚀 pushed to remote"

# ── branch prompt ─────────────────────────────────────────────────────────────
echo ""
echo "💡 want to start on a branch? type a description or hit enter to stay on main."
printf "   branch description (e.g. try noise with color): "
read BRANCH_DESC

if [ -n "$BRANCH_DESC" ]; then
  BRANCH_SLUG=$(echo "$BRANCH_DESC" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
  BRANCH_NAME="${SKETCH_ID}-${BRANCH_SLUG}"
  git checkout -b "$BRANCH_NAME"
  echo "🌿 created and switched to branch: $BRANCH_NAME"
else
  echo "💡 start exploring anytime with: new-branch <description>"
fi

echo ""
echo "📂 sketch ready: $SKETCH_DIR"

# ── open in vs code ───────────────────────────────────────────────────────────
code "$SKETCH_DIR"