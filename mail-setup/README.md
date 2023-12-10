# Mail Server setup

```
    mkdir /mailu
    cd /mailu
    docker compose -p mailu up -d
    docker compose -p mailu exec admin flask mailu admin admin test.com PASSWORD
```
