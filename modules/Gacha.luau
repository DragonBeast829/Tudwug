--!strict

type PoolItem = {
	weight: number,
	item:   unknown
}

type Pool = {
	weight: number,
	items:  {PoolItem}
}

type Banner = {
	pools:    {Pool},
	pull:     (Banner) -> unknown,
	pullMany: (Banner, number) -> {unknown}
}

local Gacha = {}

local BannerMT = {}
BannerMT.__index = BannerMT

local function buildCumulativeItems(items: {PoolItem}): ({PoolItem}, number)
	local cumulative: {PoolItem} = {}
	local total = 0
	for _, entry in ipairs(items) do
		if entry.weight < 0 then
			error("Item weight must be >= 0")
		end
		total += entry.weight
		table.insert(cumulative, {weight = total, item = entry.item})
	end
	return cumulative, total
end

local function buildCumulativePools(pools: {Pool}): ({Pool}, number)
	local cumulative: {Pool} = {}
	local total = 0
	for _, pool in ipairs(pools) do
		if pool.weight < 0 then
			error("Pool weight must be >= 0")
		end
		total += pool.weight
		table.insert(cumulative, {weight = total, items = pool.items})
	end
	return cumulative, total
end

local function sampleWeighted<T>(cumulative: {{ weight: number } & T}, total: number): T
	local r = math.random() * total
	for _, entry in ipairs(cumulative) do
		if r < entry.weight then
			return entry
		end
	end
	error("Should never reach here")
end

function BannerMT.pull(self: Banner): unknown
	local poolCumulative, poolTotal = buildCumulativePools(self.pools)
	local selectedPool = sampleWeighted(poolCumulative, poolTotal) :: Pool
	
	local itemCumulative, itemTotal = buildCumulativeItems(selectedPool.items)
	return sampleWeighted(itemCumulative, itemTotal).item
end

function BannerMT.pullMany(self: Banner, n: number): {unknown}
	local result = table.create(n)
	for i = 1, n do
		result[i] = self:pull()
	end
	return result
end

function Gacha.banner(pools: {Pool}): Banner
	return setmetatable({ pools = pools }, BannerMT) :: Banner
end

return Gacha