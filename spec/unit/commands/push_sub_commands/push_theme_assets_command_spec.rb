# encoding: utf-8

require 'spec_helper'

require 'locomotive/steam'
require 'locomotive/wagon/commands/push_sub_commands/push_base_command'
require 'locomotive/wagon/commands/push_sub_commands/push_theme_assets_command'

describe Locomotive::Wagon::PushThemeAssetsCommand do

  let(:command) { described_class.new(nil, nil, nil, nil) }

  describe '#replace_assets' do

    let(:content) { "body{background-image:url(/images/body.png)}" }
    let(:urls)    { { 'images/body.png' => 'http://cdn/images/body.png?42' } }

    before { command.instance_variable_set(:@remote_urls, urls) }

    subject { command.send(:replace_assets, content) }

    it { is_expected.to eq "body{background-image:url(http://cdn/images/body.png?42)}" }

    context 'font' do

      let(:content) { "@font-face{src: url(\"/fonts/external/myfont.woff?first\");}" }
      let(:urls)  { { 'fonts/external/myfont.woff' => 'http://cdn/fonts/external/myfont.woff?42' } }

      it { is_expected.to eq "@font-face{src: url(\"http://cdn/fonts/external/myfont.woff?42\");}" }

    end

    context 'no correct reference to an image' do

      let(:content) { "body{background-image:url(/somewhere/body.png)}" }

      it { is_expected.to eq "body{background-image:url(/somewhere/body.png)}" }

    end

  end

  describe '#persist' do

    # a stylesheet/javascript is precompiled into a tempfile, read when the asset is sent
    let(:entity) do
      Class.new do
        attr_accessor :filepath
        def realname; 'application.js'; end
        def relative_url; 'javascripts/application.js'; end
        def stylesheet_or_javascript?; true; end
        def to_hash; GC.start; { source: File.read(filepath) }; end # a GC run in between used to delete the tempfile
      end.new
    end
    let(:theme_assets) { double('theme_assets') }

    before do
      allow(command).to receive(:read_content).and_return('var a = 1;')
      allow(command).to receive(:remote_entity).and_return(nil)
      allow(command).to receive(:api_client).and_return(double(theme_assets: theme_assets))
      allow(command).to receive(:register_url)
    end

    it 'keeps the precompiled file until the asset is sent, then removes it' do
      expect(theme_assets).to receive(:create).with({ source: 'var a = 1;' }).and_return(double)
      command.persist(entity)
      expect(File.exist?(entity.filepath)).to eq false
    end

  end

end
