require 'spec_helper'

module Conchology
  describe Command do

    let(:echocmd) {Conchology::Command.new('echo')}
    let(:truecmd) {Conchology::Command.new('true')}
    let(:falsecmd) {Conchology::Command.new('false')}

    context 'readers' do
      describe '#command' do
        it 'is the command string' do
          expect(echocmd.command).to eql('echo')
        end
      end

      describe '#output' do
        it 'is an array' do
          expect(echocmd.output).to be_a(Array)
        end
      end

      describe '#error' do
        it 'is an array' do
          expect(echocmd.error).to be_a(Array)
        end
      end

      describe '#exitstatus' do
        it 'is an integer' do
          expect(echocmd.exitstatus).to be_a(Integer)
        end
      end
    end

    describe '#new' do
      it 'requires a command' do
        expect {Conchology::Command.new}.to raise_error
      end

      it 'sets up the command reader' do
        expect(Conchology::Command.new('bogus').command).to eql('bogus')
      end
    end

    describe '#run' do
      it 'set a real exit status' do
        expect(truecmd.exitstatus).to eql(-1)
        truecmd.run
        expect(truecmd.exitstatus).to eql(0)
      end

      it 'populates the output array' do
        expect(echocmd.output.length).to eq(0)
        echocmd.run
        expect(echocmd.output.length).to be > 0
      end

      it 'populates the error array' do
        errorcmd = Conchology::Command.new('echo blah 1>&2')
        expect(errorcmd.error.length).to eql(0)
        errorcmd.run
        expect(errorcmd.error.length).to be > 0
      end
    end
    
    describe '.run' do
      let(:classrun) { Conchology::Command.run('echo blah')}
      it 'is a hash' do
        expect(classrun).to be_a(Hash)
      end

      it 'includes the command exit status' do
        expect(classrun[:exitstatus]).to be_a(Integer)
      end

      it 'includes the command output' do
        expect(classrun[:output]).to be_a(Array)
        expect(classrun[:output].length).to be > 0
      end

      it 'includes the command errors' do
        expect(classrun[:error]).to be_a(Array)
        expect(classrun[:error].length).to eql(0)
      end
    end
  end
end
