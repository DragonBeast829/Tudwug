# Gacha

An overengineered weighted RNG library for [Luau](https://luau.org/). Let's go gambling!

The module can be found [here](https://github.com/DragonBeast829/Tudwug/tree/main/modules/Gacha.luau).

## Gacha module

The Gacha module contains a constructor for Banners. Very feature packed module, I know.

```luau
function Gacha.banner(
    pools: {Pool}
): Banner
```

## Types

### Banner

Banners are returned by `Gacha.banner` and store methods to perform pulls.

#### Banner.pull

Returns a single item from the banner.

```luau
function Banner.pull(): unknown
```

#### Banner.pullMany

Returns `n` items pulled from the banner. If `n <= 0`, returns an empty table.

```luau
function Banner.pullMany(n: number): {unknown}
```

### Pool

A Pool contains items that can be pulled and a weight to determine its likelihood. Banners can have multiple pools to organize different types of items.

```luau
type Pool = {
    weight: number, -- Must be >= 0. Otherwise, it will error.
    items:  {PoolItem}
}
```

### PoolItem

Represents a single item in a pool, with a weight determining its probability and the value returned when pulled.

```luau
type PoolItem = {
    weight: number, -- Must be >= 0. Otherwise, it will error.
    item:   unknown -- Items can be of any type; a string, number, table, etc.
}
```