name "base"
description "Base role"

run_list  "recipe[apt]",
          "recipe[ntp]",
          "recipe[build-essential]",
          "recipe[git]"
