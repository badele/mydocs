# LUKS on USB disk

## Requirements
- [_] `btrfs` partition
- [_] `snapper`
- [_] `snap-pac` (for snapshot after pacman installation)

## Configuration

```
# Create root config
snapper create-config -c root /
snapper create-config -c home /home

# List configs
snapper list-configs
```

## Snapshots
```
# Create snapshot
snapper -c root create [--desc comment]

# List snapshot
snapper list

# Compare snapshot
snapper -c root status id..0

# Diff snapshot file
snapper -c root diff id..0 filename

# Undo snapshot file
sudo snapper -c root -v undochange id..0 FILENAME1 FILENAME2

# rollback snapshot file
sudo snapper -c root -v rollback id

# Delete snapshot
snapper -c root delete id
```
