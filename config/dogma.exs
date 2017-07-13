# config/dogma.exs
use Mix.Config
alias Dogma.Rule

defmodule AbwRuleSet do
  @moduledoc """
  Our RuleSet. 

  It looks like Dogma.RuleSet.All but with the following changes:

  1. No ModuleDoc Rule because it's unnecessary to explain, for example, 
  what does a view module in a Phoenix application.

  2. FunctionArity Rule changed from 4 to 5 because Coherence defined a helper
  coherence_path/5 and we don't want change it for now.
  """

  alias Dogma.Rule

  @behaviour Dogma.RuleSet
  def rules do
    [
      %Rule.CommentFormat{},
      %Rule.ComparisonToBoolean{},
      %Rule.DebuggerStatement{},
      %Rule.ExceptionName{},
      %Rule.FinalCondition{},
      %Rule.FinalNewline{},
      %Rule.FunctionArity{max: 5},
      %Rule.FunctionName{},
      %Rule.FunctionParentheses{},
      %Rule.HardTabs{},
      %Rule.InfixOperatorPadding{},
      %Rule.InterpolationOnlyString{},
      %Rule.LineLength{},
      %Rule.LiteralInCondition{},
      %Rule.LiteralInInterpolation{},
      %Rule.MatchInCondition{},
      %Rule.ModuleAttributeName{},
    # %Rule.ModuleDoc{},
      %Rule.ModuleName{},
      %Rule.MultipleBlankLines{},
      %Rule.NegatedAssert{},
      %Rule.NegatedIfUnless{},
      %Rule.PipelineStart{},
      %Rule.PredicateName{},
      %Rule.QuotesInString{},
      %Rule.Semicolon{},
      %Rule.SpaceAfterComma{},
      %Rule.TakenName{},
      %Rule.TrailingBlankLines{},
      %Rule.TrailingWhitespace{},
      %Rule.UnlessElse{},
      %Rule.VariableName{},
      %Rule.WindowsLineEndings{},
    ]
  end
end

config :dogma,

  # Select a set of rules as a base
  rule_set: AbwRuleSet,


  # Override an existing rule configuration
  override: [
    %Rule.LineLength{ max_length: 125 },
  ],

  # Pick paths not to lint
  exclude: [
    ~r(\Anode_modules/phoenix_html/),
    ~r(\Anode_modules/phoenix/)
  ]
