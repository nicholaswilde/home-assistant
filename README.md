# home-assistant
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=for-the-badge)](https://pre-commit.com/)
[![task](https://img.shields.io/badge/task-enabled-brightgreen?logo=task&logoColor=white&style=for-the-badge)](https://taskfile.dev/#/)

🏠 My home assistant backup 🤖

---

## :rocket: &nbsp; TL;DR

```
cp .env.tmpl .env
# Update .env
docker compose up -d
```

---

## :electric_plug: &nbsp; Ports

| Container       | Port  |
|-----------------|-------|
| Home Assistant  | 8123  |
| ESPHome         | 6052  |
| Node-RED        | 1880  |
| Code Server     | 8443  |
| Uptime Kuma     | 3001  |

---

## :key: &nbsp; SOPS

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

---

## ​:balance_scale:​&nbsp;​ License

​[​Apache License 2.0](./LICENSE)

---

## ​:pencil:​&nbsp;​ Author

​This project was started in 2023 by [​Nicholas Wilde​](https://github.com/nicholaswilde/).
