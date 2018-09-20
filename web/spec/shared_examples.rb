shared_examples "model without required attribute" do |model, parameter|

  subject { model.new(model_attributes.except(parameter.to_sym)).valid? }
  it      { should be false }

end
