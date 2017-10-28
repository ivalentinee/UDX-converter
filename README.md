# Simple UDX to VCF converter

As I migrate from Phillips Xenium to something else I have to transfer my contacts.

But my Phillips Xenium can only export `UDF`-formatted file (which is XML), and any other phone can only import VCF (which is some weird format).

To do so I wrote that simple converter. It only transfers default phone and uses `N` as both `name` and `display name`. So no emails and stuff. But who needs that on a cellphone, huh?

## Running that piece of... software

As I mainly use docker for development I added Dockerfile. If you prefer other approaches just use ruby 2.4 (and bundler).

So for `.udx` file named `some-file.udx` you should run commands:
```
$ docker build -t udx_converter .
$ docker run --rm -it -v $(pwd):/app udx_converter bundle exec ruby udx_converter.rb some-file.udx
```
And you'll get `contacts.txt` (parsed contacts exported to `.txt` for debugging purposes) and `contacts.vcf`.

## Will it work?
I don't know. Like all that `... provided as is, without warranty of any kind ...` stuff. Sorry (`#sorrynotsorry`).
