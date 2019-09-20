# create folders
local_documents = system('cd ~/local_documents')
system('mkdir ~/local_documents') if !local_documents
coding_area = system('cd ~/local_documents/coding_area')
system('mkdir ~/local_documents/coding_area') if !coding_area
personal_projects = system('cd ~/local_documents/coding_area/personal_projects')
system('mkdir ~/local_documents/coding_area/personal_projects') unless personal_projects
clients = system('cd ~/local_documents/coding_area/clients')
system('mkdir ~/local_documents/coding_area/clients') unless clients
mac_installation = system('cd ~/local_documents/coding_area/mac_installation')
system('mkdir ~/local_documents/coding_area/mac_installation') unless mac_installation
system('cd')

# xcode
puts 'Installing coding toolkit for your new brand mac...'
system('ls')
puts 'installing xcode...'
  system('xcode-select --install')
puts 'installation of xcode finished!'

# home_brew
which_brew = system('which brew')
puts which_brew ? 'HomeBrew already installed' : 'installing HomeBrew...'

if !which_brew
  system('ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
end
system('brew update')

# oh-my-zsh
puts 'installing oh-my-zsh...'
system('sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"')

# github SSH keys
if !system('cd ~/.ssh')
  puts 'creating github keys on ~/.ssh'
  system('mkdir -p ~/.ssh && ssh-keygen -t ed25519 -o -a 100 -f ~/.ssh/id_ed25519 -C "albert.montolio@gmail.com"')
  system('cat ~/.ssh/id_ed25519.pub')
  system('open https://github.com/settings/keys')
  
  ssh_keys_in_github = system('cd ~/.ssh')
  while ssh_keys_in_github == false
    puts 'Did you add the ssh keys to your github account? y/n'
    ssh_keys_in_github = gets.chomp == 'y'
    if ssh_keys_in_github
      puts 'awesome, ssh keys are in github'
      system('ssh -T git@github.com')
    end
  end
else
  puts 'ssh keys already in mac'
end

system('export GITHUB_USERNAME=AlbertMontolio')

# sublime text 3
puts 'installing sublime text 3...'
system('brew cask install sublime-text')

# visual studio code
puts 'installing visual studio code...'
system('brew cask install visual-studio-code')

# rbenv
system('brew install rbenv')

# ruby rbenv
versions = %w(2.6.4 2.5.0)
versions.each do |version|
  system("rbenv install #{version}")
end

system("rbenv global #{versions.first}")

# install gems
system('gem install rake bundler rspec rubocop rubocop-performance pry pry-byebug hub colored octokit rails')

# utils
system('brew install wget curl node')

# more config to zhsrc
system('mkdir -p ~/local_documents/coding_area/mac_installation && cd $_ && git clone git@github.com:AlbertMontolio/albert_dotfiles.git')
system('cd ~/local_documents/coding_area/mac_installation/albert_dotfiles && zsh install.sh')

# powerline fonts for zsh
system('cd ~/local_documents/coding_area/mac_installation && git clone https://github.com/powerline/fonts.git')
system('cd fonts && ./install.sh')

# vundle for vim
system('git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim')

# install vim packages
system('vim +PluginInstall +qall')

# download personal projects
react-my-portfolio = system('cd ~/local_documents/coding_area/personal_projects ')
if !react-my-portfolio
  system('cd ~/local_documents/coding_area/personal_projects && git clone git@github.com:AlbertMontolio/react-my-portfolio.git')
  system('cd ~/local_documents/coding_area/personal_projects/react-my-portfolio && npm install')
end

# system('source ~/.zshrc')
