This directory contains `machines`, each of which represent a particular class
of machines such as servers, workstations, laptops, etc. All `machine`s share a
[./common.nix](./common.nix) base configuration which is extended by the other
classes:

# Common

The [./common.nix](./common.nix) file contains what I would consider to be a
solid foundation to build other classes of machines on.

# Server

```
nixos-rebuild switch --flake .#server
```

# Workstation

```
nixos-rebuild switch --flake .#workstation
```

# Laptop

```
nixos-rebuild switch --flake .#laptop
```
