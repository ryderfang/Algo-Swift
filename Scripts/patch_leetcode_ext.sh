#!/bin/bash
#
# patch_leetcode_ext.sh
#
# Patches the VSCode LeetCode extension to fix the
# "redeclaration of 'Solution'" issue for Swift.
#
# What it does:
#   1. Patches codeonly.tpl to wrap `class Solution {}` in #if guard
#   2. Patches core.js to replace `class Solution` with `extension Solution`
#
# Usage:
#   ./patch_leetcode_ext.sh          # auto-detect extension version
#   ./patch_leetcode_ext.sh 0.18.4   # specify version explicitly
#

set -euo pipefail

EXTENSIONS_DIR="$HOME/.vscode/extensions"

# Find extension path
if [[ $# -ge 1 ]]; then
    EXT_DIR="$EXTENSIONS_DIR/leetcode.vscode-leetcode-$1"
else
    EXT_DIR=$(find "$EXTENSIONS_DIR" -maxdepth 1 -type d -name "leetcode.vscode-leetcode-*" | sort -V | tail -1)
fi

if [[ -z "$EXT_DIR" || ! -d "$EXT_DIR" ]]; then
    echo "Error: LeetCode extension not found in $EXTENSIONS_DIR"
    echo "Install it first: ext install leetcode.vscode-leetcode"
    exit 1
fi

VERSION=$(basename "$EXT_DIR" | sed 's/leetcode.vscode-leetcode-//')
echo "Found LeetCode extension v${VERSION}"
echo "  Path: $EXT_DIR"

TPL_FILE="$EXT_DIR/node_modules/vsc-leetcode-cli/templates/codeonly.tpl"
CORE_FILE="$EXT_DIR/node_modules/vsc-leetcode-cli/lib/core.js"

# Verify files exist
for f in "$TPL_FILE" "$CORE_FILE"; do
    if [[ ! -f "$f" ]]; then
        echo "Error: $f not found"
        exit 1
    fi
done

# --- Patch 1: codeonly.tpl ---
PATCH_MARKER_TPL="#if !LC_SOLUTION_EXT"
if grep -q "$PATCH_MARKER_TPL" "$TPL_FILE"; then
    echo "[tpl] Already patched, skipping."
else
    cat > "$TPL_FILE" << 'EOF'
${comment.start}
${comment.line} @lc app=${app} id=${fid} lang=${lang}
${comment.line}
${comment.line} [${fid}] ${name}
${comment.end}

${comment.singleLine} @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

${code}
${comment.singleLine} @lc code=end
EOF
    echo "[tpl] Patched: added #if !LC_SOLUTION_EXT guard"
fi

# --- Patch 2: core.js ---
PATCH_MARKER_JS="fix 'swift' redeclaration issue"
if grep -q "$PATCH_MARKER_JS" "$CORE_FILE"; then
    echo "[js]  Already patched, skipping."
else
    # Insert the fix after `data.testcase = ...;`
    sed -i '' '/data\.testcase = util\.inspect/a\
\
  // fix '\''swift'\'' redeclaration issue\
  data.code = data.code.replace(/class Solution/g, '\''extension Solution'\'');
' "$CORE_FILE"
    echo "[js]  Patched: added class->extension Solution replacement"
fi

echo ""
echo "Done! Restart VSCode for changes to take effect."
echo ""
echo "Note: You also need to add a Custom Flag in Xcode:"
echo "  Build Settings -> Swift Compiler - Custom Flags -> Other Swift Flags"
echo "  Add: -DLC_SOLUTION_EXT"
