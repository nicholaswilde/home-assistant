# home-assistant
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=for-the-badge)](https://pre-commit.com/)
[![task](https://img.shields.io/badge/task-enabled-brightgreen?logo=task&logoColor=white&style=for-the-badge)](https://taskfile.dev/#/)

🏠 My home assistant backup

---

## :rocket: &nbsp; TL;DR

```
docker compose up -d
# browse to localhost:8123 for Home Assistant
# browse to localhost:6052 for ESPHome
```

---

## :key: &nbsp; SOPS

```shell
# sops-age = lpass entry name
# att-2571789250549588435-38084 = lpass attach id of keys.txt in sops-age entry
lpass show sops-age --attach=att-2571789250549588435-38084 -q > ~/.config/sops/age/keys.txt
sops -e ./secrets/wyze_password.txt > ./secrets/wyze_password.txt.age
sops -d ./secrets/wyze_password.txt.age > ./secrets/wyze_password.txt
```

---

## ​:balance_scale:​&nbsp;​ License

​[​Apache License 2.0](./LICENSE)

---

## ​:pencil:​&nbsp;​ Author

​This project was started in 2023 by [​Nicholas Wilde​](https://github.com/nicholaswilde/).
