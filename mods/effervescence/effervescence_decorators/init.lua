local strategy = {
  -- decoration-based gennotify node selection strategy
  gennotify = {
    register = function(self, name, ddef)
      ddef.name = name
      effervescence.register_decorator({
        name = name,
        apply_to = function(self, npmap)
          local nlist = {}
          for node,particles in pairs(npmap) do
            table.insert(nlist,node)
            npmap[node] = table.concat(particles,",")
          end
          self.nodes = npmap

          ddef.place_on = nlist
          core.register_decoration(ddef)

          self.did = core.get_decoration_id(name)
          core.set_gen_notify({ decoration = true },{ self.did })
          self.did = "decoration#" .. self.did
        end,
        decorate = function(self, minp, maxp, blockseed)
          local gennotify = core.get_mapgen_object("gennotify")
          local positions = gennotify[self.did] or {}
          for _,pos in ipairs(positions) do
            local node = core.get_node(pos).name
            local particles = self.nodes[node]
            if particles then
              local meta = core.get_meta(pos)
              meta:set_string("effervescence.particles",particles)
            end
          end
        end,
      })
    end,
  },

  -- random sample node selection strategy
  sample = {
    generation_id = 0,
    nodelist = { init = false },
    init_decorate = function(self, blockseed)
      if self.nodelist.init == false then
        local nodelist = {}
        for node,_ in pairs(self.nodelist) do
          table.insert(nodelist,node)
        end
        self.nodelist = nodelist
      end
      if blockseed ~= self.generation_id then
        self.generation_id = blockseed
        local _, emin, emax = core.get_mapgen_object("voxelmanip")
        self.nodes = core.find_nodes_in_area(emin,emax,self.nodelist,true)
      end
    end,
    register = function(self, name, per)
      local sampler = self
      effervescence.register_decorator({
        name = name,
        apply_to = function(self, npmap)
          self.nodes = npmap
          for node,particles in pairs(npmap) do
            npmap[node] = table.concat(particles,",")
            sampler.nodelist[node] = true
          end
        end,
        decorate = function(self, minp, maxp, blockseed)
          sampler:init_decorate(blockseed)
          for node,particles in pairs(self.nodes) do
            local positions = sampler.nodes[node]
            if positions then
              local plen = #positions
              local pcgr = PcgRandom(blockseed)
              for i = 0, math.floor(plen / per), 1 do
                local pos = positions[pcgr:next(1,plen)]
                local meta = core.get_meta(pos)
                meta:set_string("effervescence.particles",particles)
              end
            end
          end
        end,
      })
    end,
  },
}

-- Register gennotify decorators
strategy.gennotify:register("effervescence:floors",{
  deco_type = "simple",
  fill_ratio = 0.00375,
  decoration = "air",
  flags = "all_floors",
})

strategy.gennotify:register("effervescence:ceilings",{
  deco_type = "simple",
  fill_ratio = 0.00375,
  decoration = "air",
  flags = "all_ceilings",
})

strategy.gennotify:register("effervescence:liquid_surface",{
  deco_type = "simple",
  fill_ratio = 0.00425,
  decoration = "air",
  flags = "liquid_surface",
})

-- Register sample decorators
strategy.sample:register("effervescence:many",10)
strategy.sample:register("effervescence:few",50)
strategy.sample:register("effervescence:rare",250)