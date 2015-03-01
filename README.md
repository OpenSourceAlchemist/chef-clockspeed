clockspeed cookbook - installs djb's clockspeed from source

The clockspeed package provides a suite of utilities for checking, setting,
calibrating and maintaining the system clock of a network computer. The
package also includes a time server that may be used to precisely synchronize
the clocks of a number of computers on a network.

This cookbook configures clockspeed the Wayne Marshall way, substituting runit
for daemontools. See [the djb way/clockspeed](http://thedjbway.b0llix.net/clocksd/index.html)
for details on his installation method.  We also use the Debuntu standard /etc/service.

This cookbook creates up to 3 services: clockspeed, taiclockd, and clockspeed_adjust

## Supported Platforms
Debian 6+, Ubuntu 14.04 LTS (probably works on older versions, but this is what I test on.)

## Dependencies

### Cookbooks
* build-essential
* [sv-helper](https://github.com/rubyists/sv-helper)


## Recipes
| Name | Description |
|:-----|:------------|
| `default` | Install and configure the package

## Attributes

| attribute | default setting | description |
|:---------------------------------|:---------------|:-----------------------------------------|
|`default[:clockspeed][:user]`| `clocksd` | Define user to run the services as.  Will use users cookbook to create if available |
|`default[:clockspeed][:wait]`| `541` | Initial wait interval for adjustment mark (seconds) |
|`default[:clockspeed][:wait_max]`| `2617923` | Maximum time to wait to retrieve an adjustment mark (seconds) |
|`default[:clockspeed][:clockspeed_enabled]`| `true` | Enable the clockspeed service? |
|`default[:clockspeed][:clockspeed_adjust_enabled]`| `true` | Enable the clockspeed_adjust service? |
|`default[:clockspeed][:taiclockd_enabled]`| `true` | Enable the taiclockd service? |
|`default[:clockspeed][:sv_base]`| `/etc/sv` | Where to place our service definitions |
|`default[:clockspeed][:service_base]`| `/etc/service` | Where to link our service definitions to enable |
|`default[:clockspeed][:prefix]`| `/usr/local` | Where to build/install our work |
|`default[:clockspeed][:djb_base]`| `/usr/local/djb` | Where to build/install djb-classic code |


## Usage
Simply add clockspeed to your run_list
````
recipe[clockspeed]
````
Adjust the attributes to suit local tastes.  Note that we do NOT use the runit cookbook's resources.

## License and Author

|                      |                                                |
|:---------------------|:-----------------------------------------------|
| **Original Author**  | [Kevin Berry]( https://github.com/deathsyn) |

The MIT License (MIT)

Copyright (c) 2015 Kevin Berry

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
