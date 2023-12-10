# Mail Server setup
<span style="color: RED;"> <b>Note</b>: Its not yet ready for use</span>

```
    mkdir /mailu
    cd /mailu
    docker compose -p mailu up -d
    docker compose -p mailu exec admin flask mailu admin admin test.com PASSWORD
```



