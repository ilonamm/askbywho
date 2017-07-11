# config/dogma.exs
use Mix.Config
alias Dogma.Rule

config :dogma,

  # Select a set of rules as a base
  rule_set: Dogma.RuleSet.All,

  # Override an existing rule configuration
  override: [
    %Rule.LineLength{ max_length: 125 },
  ],

  # Pick paths not to lint
  exclude: [
    ~r(\Anode_modules/phoenix_html/),
    ~r(\Anode_modules/phoenix/)
  ]
