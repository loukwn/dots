## astrogruv

A custom gruvbox theme that uses https://github.com/Keyitdev/sddm-astronaut-theme/ as a base but modified to fit my needs (mainly removed stuff I will not use).

### Installation


1. Install **dependencies**

[`sddm >= 0.21.0`](https://github.com/sddm/sddm), [`qt6 >= 6.8`](https://doc.qt.io/qt-6/index.html), [`qt6-svg >= 6.8`](https://doc.qt.io/qt-6/qtsvg-index.html)

2. Edit `/etc/sddm.conf`
```sh
echo "[Theme]
Current=astrogruv" | sudo tee /etc/sddm.conf
```

### Licence

GPLv3.0 (or later)

### Author

[loukwn](https://github.com/loukwn)

Heavily based on the work of [Keyitdev](https://github.com/keyitdev)
