# Mail Server setup
```diff
- Note: Its not yet ready for use
```
<!--
    ```diff
    - Note: Its not yet ready for use
    + text in green
    ! text in orange
    # text in gray
    @@ text in purple (and bold)@@
    ```
-->
```
    mkdir /mailu
    cd /mailu
    docker compose -p mailu up -d
    docker compose -p mailu exec admin flask mailu admin admin test.com PASSWORD
```



