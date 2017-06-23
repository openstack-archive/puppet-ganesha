require 'puppet'
require 'puppet/type/ganesha_config'
describe 'Puppet::Type.type(:ganesha_config)' do
  before :each do
    @ganesha_config = Puppet::Type.type(:ganesha_config).new(:name => 'DEFAULT/foo', :value => 'bar')
  end

  it 'should require a name' do
    expect {
      Puppet::Type.type(:ganesha_config).new({})
    }.to raise_error(Puppet::Error, 'Title or name must be provided')
  end

  it 'should not expect a name with whitespace' do
    expect {
      Puppet::Type.type(:ganesha_config).new(:name => 'f oo')
    }.to raise_error(Puppet::Error, /Parameter name failed/)
  end

  it 'should fail when there is no section' do
    expect {
      Puppet::Type.type(:ganesha_config).new(:name => 'foo')
    }.to raise_error(Puppet::Error, /Parameter name failed/)
  end

  it 'should not require a value when ensure is absent' do
    Puppet::Type.type(:ganesha_config).new(:name => 'DEFAULT/foo', :ensure => :absent)
  end

  it 'should accept a valid value' do
    @ganesha_config[:value] = 'bar'
    expect(@ganesha_config[:value]).to eq('bar')
  end

  it 'should not accept a value with whitespace' do
    @ganesha_config[:value] = 'b ar'
    expect(@ganesha_config[:value]).to eq('b ar')
  end

  it 'should accept valid ensure values' do
    @ganesha_config[:ensure] = :present
    expect(@ganesha_config[:ensure]).to eq(:present)
    @ganesha_config[:ensure] = :absent
    expect(@ganesha_config[:ensure]).to eq(:absent)
  end

  it 'should not accept invalid ensure values' do
    expect {
      @ganesha_config[:ensure] = :latest
    }.to raise_error(Puppet::Error, /Invalid value/)
  end

  it 'should autorequire the package that install the file' do
    catalog = Puppet::Resource::Catalog.new
    package = Puppet::Type.type(:package).new(:name => 'ganesha')
    catalog.add_resource package, @ganesha_config
    dependency = @ganesha_config.autorequire
    expect(dependency.size).to eq(1)
    expect(dependency[0].target).to eq(@ganesha_config)
    expect(dependency[0].source).to eq(package)
  end


end
