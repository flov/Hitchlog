require 'i18n/tasks'
require 'ruby_cowsay'
require 'lolcat'

RSpec.describe 'I18n' do
  let(:i18n) { I18n::Tasks::BaseTask.new }
  let(:missing_keys) { i18n.missing_keys }
  let(:cows) { [
        "beavis.zen", "bong", "bud-frogs", "bunny", "cheese", "cower",
        "daemon", "default", "dragon-and-cow", "dragon", "elephant-in-snake",
        "elephant", "eyes", "flaming-sheep", "ghostbusters", "head-in",
        "hellokitty", "kiss", "kitty", "koala", "kosh", "luke-koala",
        "mech-and-cow", "meow", "milk", "moofasa", "moose", "mutilated", "ren",
        "satanic", "sheep", "skeleton", "small", "sodomized", "stegosaurus",
        "stimpy", "supermilker", "surgery", "telebears", "three-eyes",
        "turkey", "turtle", "tux", "udder", "vader-koala", "vader", "www"
  ] }

  it 'tests for missing locales' do
    expect(missing_keys).to be_empty
  end

  it 'cowsays the missing locales' do
    if missing_keys.leaves.count > 0
      puts ""
      puts(
        Lol.halp!(
          Cow.new({ cow: cows.sample }).say("Locales missing: #{missing_keys.leaves.count}")
        )
      )
      puts ""
    end
  end
end
