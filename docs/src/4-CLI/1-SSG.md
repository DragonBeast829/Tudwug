# SSG

The SSG used to generate this documentation.

## CLI Command

It takes in a source directory and an output directory. The source directory contains markdown files, which are compiled to HTML.

For example,

```bash
tudwug --src ./src --out ./out
```

## Pages & Categories

Pages are represented by individual markdown files, and categories can be created using directories in the source directory. For instance,

```text
src
├─ dir
│  └─ foo.md
└─ bar.md
```

## Naming

While pages and categories can be named whatever, starting a name with a digit and then a hyphen can order the files in numerical order as opposed to alphabetical order. For example,

```text
src
├─ apple.md
└─ banana.md

src
├─ 1-apple.md
└─ 2-banana.md
```

With the structure, apple will appear first in the sidebar as it comes first alphabetically. In the second, apple will appear after banana.