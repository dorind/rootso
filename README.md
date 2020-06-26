barebones example of library to be used with [root cern](https://root.cern.ch/)

you should have a c++ compiler installed and of course root, should you wish to install from source on a Debian based distribution, feel free to use [this script](https://github.com/dorind/nix-goodies/blob/master/install/install-root-cern.sh)

tested on **Debian 10 with root version 6.20** which was installed using [the above script](https://github.com/dorind/nix-goodies/blob/master/install/install-root-cern.sh)

## 1. clone repository

```shell
$ git clone https://github.com/dorind/rootso && cd rootso
```

## 2. build the library

```shell
$ make clean && make
```

## 3. start root, load library and play

```shell
$ root

root [0] .L rootso.so

root [1] greet()

> Welcome to "rootso" demo

root [2] fadd(2.2, 4)

> (float) 6.20000f

root [3] fdiv(1337, 0)

> (float) inff

root [4] auto x = new RootSOClass()

> (RootSOClass *) @ADDRESS

root [5] x->a = 2;

root [6] x->b = 2;

root [7] fmul(x->a, x->b)

(float) 4.00000f
```

**Notes**:
- if you modify any of the hpp or cpp files, you need to run `$ make clean && make` before you can use the new functionality
- if you add files, modify `LinkDef.h` in order for root to know about it

that's about it for a barebones library example, feel free to modify as you see fit and if you find it incompatible with your root version, open an issue



