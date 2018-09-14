
#
# Exemplo usado para verificar se model e valido, quando é removido o attributo "parameter"
# Exemplo: ./spec/models/player_spec.rb
#
shared_examples "model without required attribute" do |model, parameter|

  subject { model.new(model_attributes.except(parameter.to_sym)).valid? }
  it      { should be false }

end