require 'spec_helper'

describe 'ganesha::config' do
  describe "with default params" do
      it { is_expected.to contain_file('/etc/ganesha') }
      it { is_expected.to contain_file('/etc/ganesha/export.d') }
      it { is_expected.to contain_file('/etc/ganesha/ganesha.conf') }
      it { is_expected.to contain_file('/etc/ganesha/export.d/INDEX.conf') }
  end
end
