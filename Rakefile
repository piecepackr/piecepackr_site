require 'rake/clean'
CLOBBER << 'output'

CLEAN << 'content/images/knitr'
CLEAN << 'content/share/pnp'
CLEAN << 'content/share/rules'

rrst_files = Rake::FileList["content/**/*.Rrst"]
CLEAN << rrst_files.ext(".rst").existing
CLEAN << Rake::FileList["**/*.RData"].existing
CLEAN << "about.rst"

if ENV.has_key?("debug") # rake debug=
    debug_str = " --debug"
else
    debug_str = ""
end
ENV['RGL_USE_WEBSHOT'] = "FALSE"

rule ".rst" => ".Rrst" do |t|
    sh "Rscript -e 'knitr::knit(\"#{t.source}\", \"#{t.name}\", encoding=\"UTF-8\")'"
end

file 'content/pages/pnp.Rrst' => Rake::FileList["content/Articles/*_pnp.Rrst"].ext(".rst")
file 'content/pages/rules.Rrst' => "content/Articles/game_starts.rst" 
file 'content/Articles/game_starts.Rrst' => Rake::FileList["content/Articles/*_game.Rrst"].ext(".rst")
file 'content/Articles/game_starts.Rrst' => "content/Articles/chess_pnp.rst" 
file 'content/Articles/configuration.Rrst' => "content/pages/pnp.rst"

file 'about.Rrst' => Rake::FileList["content/Articles/*.Rrst"].ext(".rst")

file 'content/pages/about.Rrst' => "about.rst"
file 'content/pages/index.Rrst' => "about.rst"

desc "Build website"
task :default => rrst_files.ext(".rst")
task :default do
    sh "pelican -o output -s pelicanconf.py content" + debug_str
end

desc "Deploy website to trevor.l.davis.com/piecepackr"
task :deploy => :default
task :deploy do
    do_dry_run = ENV.has_key?("dry_run") # rake deploy dry_run=
    cmd = "rsync -avh --delete output/ trevorld@trevorldavis.com:public_html/piecepackr/"
    if do_dry_run
        cmd = cmd + " --dry-run"
    end
    sh cmd
end

desc "Test website on localhost:8000"
task :test => rrst_files.ext(".rst")
task :test do
    sh "pelican -o output -s pelicanconf.py --relative-urls content" + debug_str
    Dir.chdir("output") do
        sh "python3 -m http.server"
    end
end

