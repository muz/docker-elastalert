# docker-elastalert

Deploys a Docker container with a mounted volume containing all config and rules.

## Usage

 * Create a directory containing your `config.yaml` and a `rules.d` directory with your rules. 

```
mkdir -p /opt/elastalert/rules.d
touch /opt/elastalert/config.yaml
```

 * Deploy a container mounting this folder as `/etc/elastalert`

`docker run -v /opt/elastalert:/etc/elastalert --name elastalert muzzz/elastalert`

n.b. Elastalert exits on start if there are no rules defined.
