## How to use

### Create ssh host keys

```sh
mkdir host-keys
docker run -it --rm -e HOST_KEYS='/host-keys' -v `pwd`/host-keys:/host-keys cnosuke/rsshproxy
```
