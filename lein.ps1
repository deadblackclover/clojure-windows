Param(
    [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
    [string[]]$Command = 'help'
)

$env:LEIN_VERSION = "2.12.0"
$env:LEIN_JAR = "$($PSScriptRoot)\leiningen-$env:LEIN_VERSION-standalone.jar"

function SelfInstall {
    Invoke-WebRequest -Uri "https://codeberg.org/leiningen/leiningen/releases/download/$env:LEIN_VERSION/leiningen-$env:LEIN_VERSION-standalone.jar" -OutFile $env:LEIN_JAR
}

$JavaArgs = @(
    '-cp', $env:LEIN_JAR
    'clojure.main'
    '-m', 'leiningen.core.main'
)

switch ($Command[0]) {
    self-install { SelfInstall }
    Default { &java @JavaArgs @Command }
}
