# Inspire for OSX

Simple OSX application to inspire you to be creative, to be present or to take a conscious breath.

![Inspire](inspire.gif)


## Usage

**Help:**:

```
inspire --help
USAGE: inspire [--mode <mode>] [--gap <gap>]

OPTIONS:
  --mode <mode>           Mode [short, normal, deep]. (default: normal)
  --gap <gap>             Gap in seconds. (default: 2)
  -h, --help              Show help information.
```

**Run in background:**

```
nohup inspire > output.log 2>&1 &
```
