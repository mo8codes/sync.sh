# Define paths SYNCED_DIR = On device path, the other two are locations to clone to/from
SYNCED_DIR="/home/mo/SYNCED"
CLONE1_DIR="/run/media/mo/CLONE1"
CLONE2_DIR="/run/media/mo/CLONE2"

# Function to check if path exists
check_path() {
    if [ ! -d "$1" ]; then
        echo "❌ Directory not found: $1"
        exit 1
    fi
}

# Option 1: Sync SYNCED to CLONE1 and CLONE2
sync_synced_to_clones() {
    check_path "$SYNCED_DIR"
    check_path "$CLONE1_DIR"
    check_path "$CLONE2_DIR"

    echo "🔁 Syncing $SYNCED_DIR to $CLONE1_DIR..."
    rsync -av --delete "$SYNCED_DIR/" "$CLONE1_DIR/"

    echo "🔁 Syncing $SYNCED_DIR to $CLONE2_DIR..."
    rsync -av --delete "$SYNCED_DIR/" "$CLONE2_DIR/"

    echo "✅ Sync complete from SYNCED to CLONE1 and CLONE2."
}

# Option 2: Sync CLONE1 to SYNCED and CLONE2
sync_clone1_to_main_and_clone2() {
    check_path "$SYNCED_DIR"
    check_path "$CLONE1_DIR"
    check_path "$CLONE2_DIR"

    echo "🔁 Syncing $CLONE1_DIR to $SYNCED_DIR..."
    rsync -av --delete "$CLONE1_DIR/" "$SYNCED_DIR/"

    echo "🔁 Syncing $CLONE1_DIR to $CLONE2_DIR..."
    rsync -av --delete "$CLONE1_DIR/" "$CLONE2_DIR/"

    echo "✅ Sync complete from CLONE1 to ~/SYNCED and CLONE2."
}

# Menu
echo "Please select an option:"
echo "1. Sync SYNCED → CLONE1 & CLONE2"
echo "2. Sync CLONE1 → ~/SYNCED & CLONE2"
read -rp "Enter 1 or 2: " choice

case "$choice" in
    1)
        sync_synced_to_clones
        ;;
    2)
        sync_clone1_to_main_and_clone2
        ;;
    *)
        echo "❌ Invalid option."
        exit 1
        ;;
esac
