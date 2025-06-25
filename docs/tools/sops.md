---
tags:
 - tools
---
# :key: SOPS

[SOPS][1] is used to encrypt files that contain secrets. The encrypted copy of the file ends in `*.enc`.

```shell
# sops-age = lpass entry name
# att-2571789250549588435-38084 = lpass attach id of keys.txt in sops-age entry
mkdir -p ~/.config/sops/age
lpass show sops-age --attach=att-2571789250549588435-38084 -q > ~/.config/sops/age/keys.txt
# or
age-keygen -o ~/.config/sops/age/keys.txt
sops -e --input-type yaml --output-type yaml ./ha/secrets.yaml > ./ha/secrets.yaml.enc
sops -d --input-type yaml --output-type yaml ./ha/secrets.yaml.enc > ./ha/secrets.yaml
```

[1]: <https://getsops.io/>
