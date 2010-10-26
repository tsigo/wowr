require 'spec_helper'

module Wowr::Armory::Item
  describe CreatedBy do
    subject { CreatedBy.new(fake_element) }

    # FIXME: This has no accessor; is it supposed to? Love that consistency. (tsigo)
    its(:item) { should be_nil }

    protected

    def fake_element
      xml = <<-XML
      <createdBy>
        <spell icon="trade_engineering" id="32867" name="Bracing Earthstorm Diamond">
          <reagent count="1" icon="inv_misc_gem_diamond_04" id="25867" name="Earthstorm Diamond" quality="3"/>
        </spell>
      </createdBy>
      XML

      (Hpricot.XML(xml)%'createdBy')
    end
  end
end
