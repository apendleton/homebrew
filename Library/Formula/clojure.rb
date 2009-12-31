require 'formula'

class Clojure <Formula
  url 'http://clojure.googlecode.com/files/clojure_1.0.0.zip'
  md5 'e7a50129040df7fe52287006988ecbb2'
  head 'git://github.com/richhickey/clojure.git'
  homepage 'http://clojure.org/'
  JAR = "clojure-1.0.0.jar"

  def script
    DATA.read.gsub 'CLOJURE_JAR_PATH_PLACEHOLDER', prefix+JAR
  end

  def install
    prefix.install JAR
    (bin+'clj').write(script)
  end
end

__END__
#!/bin/bash
# Runs clojure.
# With no arguments, runs Clojure's REPL.
# With one or more arguments, the first is treated as a script name, the rest
# passed as command-line arguments.

# resolve links - $0 may be a softlink
CLOJURE=$CLASSPATH:CLOJURE_JAR_PATH_PLACEHOLDER

if [ -z "$1" ]; then
	java -server -cp $CLOJURE clojure.lang.Repl
else
	scriptname=$1
	java -server -cp $CLOJURE clojure.lang.Script $scriptname -- $*
fi
