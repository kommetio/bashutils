### Generating multiple subdomains with different ports in Apache2

This script generates multiple domain configuration files in Apache2. Each configuration file contains a subdomain mapping to a different port.

* sandbox001.* => 9001
* sandbox002.* => 9002
* etc.

To achieve this, run `create-subdomains.sh`. This will create multiple `.conf` files named `sandbox001.conf`, `sandbox002.conf` etc.
The contents of the `.conf` files are based on the template file `subdomain-template`.

