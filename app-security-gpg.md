# GPG

## Keys creation and revoke old key
```
# Main key (Certify only)
gpg --quick-gen-key '<brunoadele@gmail.com>' rsa4096 cert 2y
export GPG_USERID=$(gpg -K | grep -oE "[a-fA-F0-9]{40}")

# Subkey
gpg --quick-addkey ${GPG_USERID} rsa4096 sign 2y
gpg --quick-addkey ${GPG_USERID} rsa4096 encr 2y
gpg --quick-addkey ${GPG_USERID} rsa4096 auth 2y

# Add adduid and photo [Optional]
gpg --quick-add-uid ${GPG_USERID} <new_email>
gpg --edit-key ${GPG_USERID}
gpg> trust
gpg> addphoto filename
gpg> save
gpg --check-trustdb

# Import old key [Optional]
gpg --import <oldkey>
gpg --edit-key <oldkey>
gpg> setpref clean quit

# Sign a new key with the oldkey if the key is not too old [Optional]
gpg --default-key <oldkeyid> --sign-key ${GPG_USERID}

# Sign oldkey with newkey [Optional]
gpg --default-key ${GPG_USERID} --sign-key <oldkey>

# Revoke oldkey [Optional]
gpg --gen-revoke <oldkey> > /tmp/revoke.asc
gpg --import /tmp/revoke.asc
gpg --send-keys <oldkey>

# Push public keys
gpg --send-key ${GPG_USERID}

# Backup (script in .local/bin)
# Before run bellow command, edit ~/.config/zsh/variables.zsh (GPG_USERID and GPG_BACKUP_DIR)
gpg-backup-keys

# Secure keys (delete primary key from computer)
# WARNING, delete only the primary key, it is also requested to delete the sub-keys
gpg --delete-secret-key ${GPG_USERID}

# Verify the computer not contain primary key
gpg -K # You should see 'sec#', indicates that the master key does not have a private key
```

# Re-import the private key & sub-keys
gpg --import ${GPG_BACKUP_DIR}/lastkeys/secret_key.gpg
gpg --import ${GPG_BACKUP_DIR}/lastkeys/secret_subkeys.gpg

## Update algorithme, expiration date, password
```
gpg --edit-key ${GPG_USERID}
key 0
setpref
expire
passwd
save
```

# Yubikey

# Show gpg content

```
gpg2 --card-status
```

## Edit GPG PIN

```
gpg2 --card-edit
passwd
```

## Edit gpg informations

```
gpg2 --card-edit
name
lang
login
sex
```

## Move gpg to yubikey

```
gpg2 -K
gpg2 --expert --edit-key <GPGID>
key 1
keytocard
key 2
keytocard
key 3
keytocard
save
quit
```


## Verify moved gpg key to yubikey
```
gpg2 -K
# You should see 'ssb>', indicates that the subkey key does not have a private key
```

## GPG agent configuration for SSH and GIT
See files
- `~/.gnupg/gpg-agent.conf`
- `~/.gnupg/sshcontrol`
- `.gitconfig`
- `ssh-add -L` # show public SSH key

## Annex
```
# Show key information
gpg --edit-key <keyid>
gpg> showpref
# Another method
gpg --export <keyid> | gpg --list-packets

# show a key was signed by another key
gpg --list-sig <keyid>

# Import key
gpg --import <key file>

# Import remote key
gpg --recv-keys <keyid>

# Edit key
gpg --edit-key <keyid>

# Encrypt file
gpg --encrypt -o <encrypted file> [--recipient <keyid>] <file to encrypt>

# Decrypt
gpg --decrypt -o <encrypted file> <file to decrypt>

# Sign
gpg -o <sign file> --sign <file to sign>

# sign verification
gpg --verify <sign file>
```

## Troubles

```
#for f in $(ls ~/.ssh/*.pub); do
#  ssh-keygen -l -E md5 -f $f
#done
gpg-connect-agent "KEYINFO --ssh-list --ssh-fpr" /bye
gpg-connect-agent "DELETE_KEY <IDKEYS>" /bye
```



## Sources
- https://linuxfr.org/users/gouttegd/journaux/bien-demarrer-avec-gnupg
- https://www.nextinpact.com/article/25351/102685-gpg-comment-creer-paire-clefs-presque-parfaite
- https://www.nbs-system.com/publications/expertise/creation-de-sa-cle-gpg-et-utilisation-avec-passwordstore-enigmail-gpg-agent/
- https://alexcabal.com/creating-the-perfect-gpg-keypair
- https://www.pragmageek.fr/2015/04/renouvellement-cle-pgp/#remplacement-ancienne-cle
